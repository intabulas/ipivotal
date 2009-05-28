//
//  iPivotalAppDelegate.h
//  iPivotal
//
//  Created by Mark Lussier on 5/28/09.
//  Copyright Juniper Networks 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iPivotalAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *navigationController;
    UIToolbar *toolbar;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end
