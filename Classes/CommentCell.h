#import <UIKit/UIKit.h>

@class PivotalNote;
@interface CommentCell : UITableViewCell {
   PivotalNote *comment;
    IBOutlet UITextView *commentText;
    IBOutlet UILabel *fromLabel;
}

@property (nonatomic,retain) PivotalNote *comment;

@end
