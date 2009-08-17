#import <UIKit/UIKit.h>

@class CommentCell, PivotalStory, PivotalProject;
@interface CommentsController : UIViewController <UITableViewDelegate> {

    IBOutlet UITableView *commentTableView;
    IBOutlet CommentCell *commentCell;
    PivotalStory *story;
    PivotalProject *project;
    NSArray *comments;
    
}

-(id)initWithProject:(PivotalProject *)theProject andStory:(PivotalStory *)theStory;

-(void)composeReply:(id)sender;
@end
