#import <UIKit/UIKit.h>
#import "PivotalStory.h"
#import "PivotalProject.h"

@interface StoryViewController : UIViewController {
   PivotalStory *story;
    PivotalProject *project;
   @private
    IBOutlet UILabel *name;
    IBOutlet UILabel *estimate;
    IBOutlet UIImageView *typeIcon;
    IBOutlet UIImageView *estimateIcon;
    IBOutlet UILabel *currentState;
    IBOutlet UILabel *requestedBy;
    IBOutlet UILabel *ownedBy;    
    IBOutlet UITextView *description;
    IBOutlet UIBarButtonItem *startButton;
}

- (id)initWithStory:(PivotalStory *)theStory;
- (id)initWithStory:(PivotalStory *)theStory andProject:(PivotalProject *)theProject;
- (IBAction)startStory:(id)sender;

@property (nonatomic,retain) PivotalStory* story;
@property (nonatomic,retain) PivotalProject *project;


@end
