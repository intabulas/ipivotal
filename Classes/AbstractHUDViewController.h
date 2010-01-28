//
//  AbstractHUDViewController.h
//  PTCruiser
//
//  Created by Mark Lussier on 1/28/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface AbstractHUDViewController : UIViewController <MBProgressHUDDelegate> {
    MBProgressHUD *hudDisplay;
    BOOL isHudDisplayed;

}

@property (nonatomic,assign) BOOL isHudDisplayed;
- (void)showHUDWithLabel:(NSString*)label;
- (void)hideHUD;
- (void)showHUD;

@end
