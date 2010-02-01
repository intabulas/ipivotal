//
//  AbstractHUDViewController.m
//  PTCruiser
//
//  Created by Mark Lussier on 1/28/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "AbstractHUDViewController.h"


@implementation AbstractHUDViewController
@synthesize isHudDisplayed;

#pragma mark -
#pragma mark MBProgressHUDDelegate methods


- (void)hideHUD {
    if ( isHudDisplayed ) {
        isHudDisplayed = NO;
        [hudDisplay hide:NO];
    }
}

- (void)showHUDWithLabel:(NSString*)label {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    hudDisplay = [[MBProgressHUD alloc] initWithWindow:window];
    [window addSubview:hudDisplay];
    hudDisplay.delegate = self;
    [hudDisplay setLabelText:label];
    isHudDisplayed = YES;
    [hudDisplay  show:YES];        
    
}

- (void)showHUD {
    if (!isHudDisplayed) {
       [self showHUDWithLabel:kLabelLoading];
    }
}


- (void)hudWasHidden {
    // Remove HUD from screen when the HUD was hidded
    isHudDisplayed = NO;
    [hudDisplay removeFromSuperview];
    [hudDisplay release];
}
@end
