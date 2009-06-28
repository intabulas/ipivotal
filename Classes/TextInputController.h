#import <UIKit/UIKit.h>


@interface TextInputController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
    IBOutlet UITableView *listTableView;

}


- (void)textFieldDidEndEditing:(UITextField *)textField;
@property (nonatomic,retain)  IBOutlet  UITableView *listTableView;

@end
