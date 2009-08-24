#import "iPivotalAppDelegate.h"
#import "AuthenticationViewController.h"
#import "Reachability.h"

@interface iPivotalAppDelegate ()
- (void)postLaunch;
- (void)presentLogin;
- (void)authenticate;
@end



@implementation iPivotalAppDelegate

@synthesize internetConnectionStatus, remoteHostStatus, localWiFiConnectionStatus;


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
		[self presentLogin];
	} else {
        if (self.loginController) [navigationController dismissModalViewControllerAnimated:YES];
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
	[navigationController release];
    [toolbar release];
	[window release];
	[super dealloc];
}

@end
