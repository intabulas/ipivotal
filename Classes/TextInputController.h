#import <UIKit/UIKit.h>


@interface TextInputController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
    IBOutlet UITableView *listTableView;
    IBOutlet UITableViewCell *textInputCell;
    IBOutlet UITextField *textField;
    NSMutableDictionary *editingItem;
    NSString *inputTitle;
}


@property (nonatomic,retain)  IBOutlet  UITableView *listTableView;
@property (nonatomic,retain) NSMutableDictionary *editingItem;


- (id)initWithTitle:(NSString *)theTitle;

- (IBAction) saveInput:(id)sender;

@end