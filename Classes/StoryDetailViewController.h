
#import <UIKit/UIKit.h>

@class PivotalStory, PivotalProject;
@interface StoryDetailViewController : UITableViewController {
    PivotalStory *story;
    PivotalProject *project;
    @private    
    IBOutlet UIView *tableHeaderView;
    IBOutlet UITableViewCell *commentsCell;
    IBOutlet UITableViewCell *ownerCell;
    IBOutlet UITableViewCell *requestorCell;
    IBOutlet UITableViewCell *descriptionCell;
    IBOutlet UITableViewCell *stateCell;  
    IBOutlet UILabel *storyOwner;
    IBOutlet UILabel *storyState;
    IBOutlet UILabel *storyRequestor;
    IBOutlet UITextView *storyDescription;    
    IBOutlet UILabel *storyName;

    IBOutlet UILabel *estimate;
    IBOutlet UIImageView *typeIcon;
    IBOutlet UIImageView *estimateIcon;
    
}

- (id)initWithStory:(PivotalStory *)theStory;
- (id)initWithStory:(PivotalStory *)theStory andProject:(PivotalProject *)theProject;

@property (nonatomic,retain) PivotalStory* story;
@property (nonatomic,retain) PivotalProject *project;

@end
