#import <UIKit/UIKit.h>

@class CommentCell;
@interface CommentsController : UIViewController <UITableViewDelegate> {

    IBOutlet UITableView *commentTableView;
    IBOutlet CommentCell *commentCell;
 
    NSArray *comments;
    
}

-(id)initWithComments:(NSArray *)theComments;
-(void)composeReply:(id)sender;
@end
