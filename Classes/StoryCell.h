
#import <Foundation/Foundation.h>
#import "PivotalStory.h"

@interface StoryCell : UITableViewCell {
    PivotalStory *story;
@private 
    IBOutlet UIImageView *icon;
    IBOutlet UIImageView *estimateIcon;    
    IBOutlet UILabel *name;    
    IBOutlet UILabel *state;
}

@property (nonatomic,retain) PivotalStory *story;

@end
