#import <UIKit/UIKit.h>
#import "AuthenticationViewController.h"
#import "ProjectsViewController.h"

@interface iPivotalAppDelegate : NSObject <UIApplicationDelegate> {
    IBOutlet UIWindow *window;
    IBOutlet UINavigationController *navigationController;
    IBOutlet UIToolbar *toolbar;
    IBOutlet ProjectsViewController *projectsController;     
}

@property (nonatomic, readonly) AuthenticationViewController *loginController;

@end
