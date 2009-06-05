#import <UIKit/UIKit.h>


@interface AuthenticationViewController : UITableViewController {
	id target;
	SEL selector;    
    IBOutlet UINavigationBar *settingsHeader;
    IBOutlet UITableViewCell *tokenCell;
    IBOutlet UITableViewCell *sslCell;    
    IBOutlet UITextField *tokenField;
    IBOutlet UISwitch *sslField; 
    
}

- (IBAction)saveAuthenticationCredentials:(id)sender;
- (id)initWithTarget:(id)theTarget andSelector:(SEL)theSelector;


@end
