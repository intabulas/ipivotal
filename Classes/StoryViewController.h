#import <UIKit/UIKit.h>
#import "PivotalStory.h"

@interface StoryViewController : UIViewController {
   PivotalStory *story;
   @private
    IBOutlet UILabel *name;
    IBOutlet UILabel *estimate;
    IBOutlet UIImageView *typeIcon;
    IBOutlet UIImageView *estimateIcon;
    IBOutlet UILabel *currentState;
    IBOutlet UILabel *requestedBy;
    IBOutlet UILabel *ownedBy;    
    IBOutlet UITextView *description;
}

- (id)initWithStory:(PivotalStory *)theStory;

@property (nonatomic,retain) PivotalStory* story;


@end
