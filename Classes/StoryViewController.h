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
    IBOutlet UIBarButtonItem *finishButton;    
    IBOutlet UIBarButtonItem *deliverButton;    
    IBOutlet UIBarButtonItem *acceptButton;    
    IBOutlet UIBarButtonItem *rejectButton;       
    IBOutlet UIBarButtonItem *restartButton;           
    IBOutlet UIToolbar *toolbar;
}

- (id)initWithStory:(PivotalStory *)theStory;
- (id)initWithStory:(PivotalStory *)theStory andProject:(PivotalProject *)theProject;

- (void)toggleStoryState:(NSString *)newState;

- (IBAction)startStory:(id)sender;
- (IBAction)finishStory:(id)sender;
- (IBAction)deliverStory:(id)sender;
- (IBAction)acceptStory:(id)sender;
- (IBAction)rejectStory:(id)sender;

@property (nonatomic,retain) PivotalStory* story;
@property (nonatomic,retain) PivotalProject *project;


@end
