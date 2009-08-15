
#import <UIKit/UIKit.h>

@class PivotalStory, PivotalProject;
@interface StoryDetailViewController : UIViewController <UITableViewDelegate, UIActionSheetDelegate> {
    PivotalStory *story;
    PivotalProject *project;
    @private    
    IBOutlet UITableView *storyTableView;
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
- (IBAction)showActions:(id)sender;
- (id)initWithStory:(PivotalStory *)theStory andProject:(PivotalProject *)theProject;
- (void)toggleStoryState:(NSString *)newState ;

@property (nonatomic,retain) PivotalStory* story;
@property (nonatomic,retain) PivotalProject *project;
@property (nonatomic,retain) IBOutlet UITableView *storyTableView;


@end
