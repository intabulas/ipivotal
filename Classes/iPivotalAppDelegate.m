//
//	Copyright (c) 2008-2010, Mark Lussier
//	http://github.com/intabulas/ipivotal
//	All rights reserved.
//
//	This software is released under the terms of the BSD License.
//	http://www.opensource.org/licenses/bsd-license.php
//
//	Redistribution and use in source and binary forms, with or without modification,
//	are permitted provided that the following conditions are met:
//
//	* Redistributions of source code must retain the above copyright notice, this
//	  list of conditions and the following disclaimer.
//	* Redistributions in binary form must reproduce the above copyright notice,
//	  this list of conditions and the following disclaimer
//	  in the documentation and/or other materials provided with the distribution.
//	* Neither the name of iPivotal nor the names of its contributors may be used
//	  to endorse or promote products derived from this software without specific
//	  prior written permission.
//
//	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//	ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
//	IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
//	INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
//	BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
//	DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
//	LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
//	OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
//	OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "iPivotalAppDelegate.h"
#import "AuthenticationViewController.h"
#import "Reachability.h"
#import "EGODatabase.h"

@interface iPivotalAppDelegate (private)
    - (void) postLaunch;
    - (void) presentLogin;
    - (void) authenticate;
    - (void) checkForDatabase:(id)sender;
@end



@implementation iPivotalAppDelegate

@synthesize internetConnectionStatus, remoteHostStatus, localWiFiConnectionStatus, database;

- (void) checkForDatabase:(id)sender {
    
    if ( self.database != nil && [self.database open] ) {
        [self.database close];
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];    
    NSError *err;    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];    
    NSString *databaseFile =  [documentsDirectory stringByAppendingPathComponent:@"ptcruiser.sqlite"];     
    if ( ![fileManager fileExistsAtPath:databaseFile] ) {        
        NSString *srcPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DATABASE_FILE_NAME];
        PTLog(@"Initializing with Empty Database from: %@", srcPath);
        [[NSFileManager defaultManager] copyItemAtPath:srcPath toPath:databaseFile  error:&err];
    }
    
    self.database = [EGODatabase databaseWithPath:databaseFile];
    
    if ( ![self.database open] ) {
        PTLog(@"Error Opening Database!!");      
    }     
    
}




- (void)reachabilityChanged:(NSNotification *)note {
    
    [self updateStatus];
}

- (BOOL)hasNoInternetConnectivity {
    return ( self.internetConnectionStatus != ReachableViaCarrierDataNetwork && self.localWiFiConnectionStatus != ReachableViaWiFiNetwork );    
}

- (void)updateStatus
{
    // Query the SystemConfiguration framework for the state of the device's network connections.
    self.remoteHostStatus = [[Reachability sharedReachability] remoteHostStatus];
    self.internetConnectionStatus    = [[Reachability sharedReachability] internetConnectionStatus];
    self.localWiFiConnectionStatus	= [[Reachability sharedReachability] localWiFiConnectionStatus];

    if (self.internetConnectionStatus == NotReachable && self.remoteHostStatus == NotReachable && self.localWiFiConnectionStatus == NotReachable) {
        //show an alert to let the user know that they can't connect...
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Unavailable" message:@"PT Cruiser requires an active network connection to communicate with Pivotal Tracker\n\n Please try again when an internet connection is available" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Exit", nil];
        [alert show];
        [alert release];
    } else {
    }
}

-(void)initStatus {
    self.remoteHostStatus = [[Reachability sharedReachability] remoteHostStatus];
    self.internetConnectionStatus    = [[Reachability sharedReachability] internetConnectionStatus];
    self.localWiFiConnectionStatus    = [[Reachability sharedReachability] localWiFiConnectionStatus];    
}

#pragma mark AlertView delegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [alertView release];
    [self applicationWillTerminate:[UIApplication sharedApplication]];
    exit(0);
}
- (void)applicationDidFinishLaunching:(UIApplication *)application {
	

    [self checkForDatabase:self];
    
    pivotalManager = [[PivotalManager alloc] init];
    


    [[Reachability sharedReachability] setHostName:kPivotalTrackerHost];
    [[Reachability sharedReachability] setNetworkStatusNotificationsEnabled:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:@"kNetworkReachabilityChangedNotification" object:nil];
    [self initStatus];
//    [self updateStatus];
    
	
    [self authenticate];
    
	// Configure and show the window
	[window addSubview:[navigationController view]];    
	[window makeKeyAndVisible];
    
	[self performSelector:@selector(postLaunch) withObject:nil afterDelay:0.0];    

    
}


- (void)postLaunch {
	[self authenticate];
}


- (void)presentLogin {
    AuthenticationViewController *loginController = [[AuthenticationViewController alloc] initWithTarget:self andSelector:@selector(authenticate)];
    [navigationController presentModalViewController:loginController animated:YES];
    [loginController release];
}    


- (void)authenticate {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults valueForKey:kDefaultsApiToken];
    
    if ( !token ) {
        if ( projectsController != nil ) {
           [projectsController hideHeadsUpDisplay];
        }
		[self presentLogin];
	} else {
        if (self.loginController) {
            [navigationController dismissModalViewControllerAnimated:YES];
        }
        [projectsController reloadProjects];
	}
}


- (AuthenticationViewController *)loginController {
	return (AuthenticationViewController *)navigationController.modalViewController ;
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


- (void)dealloc {
    RELEASE_SAFELY(database);
    RELEASE_SAFELY(pivotalManager);
    RELEASE_SAFELY(navigationController);
    RELEASE_SAFELY(toolbar);
    RELEASE_SAFELY(window);
	[super dealloc];
}

@end
