#import <UIKit/UIKit.h>


@interface TextInputController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
    IBOutlet UITableView *listTableView;
    IBOutlet UITableViewCell *textInputCell;
    IBOutlet UITextField *textField;
    NSMutableDictionary *editingItem;
    
}


@property (nonatomic,retain)  IBOutlet  UITableView *listTableView;
@property (nonatomic,retain) NSMutableDictionary *editingItem;

- (IBAction) saveInput:(id)sender;

@end
