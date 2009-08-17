#import <UIKit/UIKit.h>


@interface AuthenticationViewController : UITableViewController <UITextFieldDelegate, UIAlertViewDelegate> {
	id target;
	SEL selector;    
    IBOutlet UINavigationBar *settingsHeader;
    IBOutlet UITableViewCell *tokenCell;
    IBOutlet UITableViewCell *sslCell;    
    IBOutlet UITextField *tokenField;
    IBOutlet UISwitch *sslField; 
    IBOutlet UIView *tableFooterView;
    UITextField *usernameField;
    UITextField *passwordField;    
}

- (IBAction)saveAuthenticationCredentials:(id)sender;
- (id)initWithTarget:(id)theTarget andSelector:(SEL)theSelector;

-(IBAction)retrieveToken:(id)sender;

-(IBAction)lookupToken:(id)sender;

@end
