#import <UIKit/UIKit.h>
#import "AuthenticationViewController.h"
#import "ProjectsViewController.h"
#import "Reachability.h"


@interface iPivotalAppDelegate : NSObject <UIApplicationDelegate> {
    IBOutlet UIWindow *window;
    IBOutlet UINavigationController *navigationController;
    IBOutlet UIToolbar *toolbar;
    IBOutlet ProjectsViewController *projectsController;     
    NetworkStatus internetConnectionStatus;
    NetworkStatus remoteHostStatus;
    NetworkStatus localWiFiConnectionStatus;
}

@property (nonatomic, readonly) AuthenticationViewController *loginController;
@property NetworkStatus internetConnectionStatus;
@property NetworkStatus remoteHostStatus;
@property NetworkStatus localWiFiConnectionStatus;

- (BOOL)hasNoInternetConnectivity;
- (void)reachabilityChanged:(NSNotification *)note;
- (void)updateStatus;
- (void)authenticate;
- (void)initStatus;
@end
