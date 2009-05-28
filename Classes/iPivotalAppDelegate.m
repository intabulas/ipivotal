//
//  iPivotalAppDelegate.m
//  iPivotal
//
//  Created by Mark Lussier on 5/28/09.
//  Copyright Juniper Networks 2009. All rights reserved.
//

#import "iPivotalAppDelegate.h"


@implementation iPivotalAppDelegate

@synthesize window;
@synthesize navigationController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	// Configure and show the window
	[window addSubview:[navigationController view]];    
	[window makeKeyAndVisible];
    
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
