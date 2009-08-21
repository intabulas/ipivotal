#import <UIKit/UIKit.h>

@class PivotalNote;
@interface CommentCell : UITableViewCell {
   PivotalNote *comment;
    IBOutlet UITextView *commentText;
}

@property (nonatomic,retain) PivotalNote *comment;

-(CGFloat)getHeight;
@end
