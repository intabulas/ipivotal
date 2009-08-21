#import <UIKit/UIKit.h>

@class PivotalNote;

@interface AddCommentController : UITableViewController <UITextFieldDelegate> {
    IBOutlet UITextView *commentBody;
    IBOutlet UITableViewCell *commentCell;
	IBOutlet UIActivityIndicatorView *activityView;
	IBOutlet UIButton *saveButton;
	IBOutlet UIView *tableFooterView;
    
    
    PivotalNote *note;

}

-(id)initWithNote:(PivotalNote *)theNote;
- (IBAction)saveNote:(id)sender;

@end
