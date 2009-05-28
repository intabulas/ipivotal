//
//  iPivotalAppDelegate.m
//  iPivotal
//
//  Created by Mark Lussier on 5/28/09.
//  Copyright Juniper Networks 2009. All rights reserved.
//

#import "iPivotalAppDelegate.h"
#import "AuthenticationViewController.h"

@interface iPivotalAppDelegate ()
- (void)postLaunch;
- (void)presentLogin;
- (void)authenticate;
@end


@implementation iPivotalAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize toolbar;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
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
