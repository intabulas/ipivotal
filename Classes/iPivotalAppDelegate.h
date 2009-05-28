//
//  iPivotalAppDelegate.h
//  iPivotal
//
//  Created by Mark Lussier on 5/28/09.
//  Copyright Juniper Networks 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iPivotalAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
