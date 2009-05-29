
#import <Foundation/Foundation.h>
#import "PivotalStory.h"

@interface StoryCell : UITableViewCell {
    PivotalStory *story;
@private 
    IBOutlet UIImageView *icon;
    IBOutlet UILabel *name;    
}

@property (nonatomic,retain) PivotalStory *story;

@end
