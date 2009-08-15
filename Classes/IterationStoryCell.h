#import <UIKit/UIKit.h>
#import "PivotalStory.h"

@interface IterationStoryCell : UITableViewCell {
PivotalStory *story;
@private
   UIImageView *typeImage;
   UIImageView *estimateImage;
   UILabel *storyLabel;
   UILabel *statusLabel;
   UILabel *commentsLabel;

}

@property (nonatomic,readonly) UIImageView *typeImage;
@property (nonatomic,readonly) UIImageView *estimateImage;
@property (nonatomic,readonly) UILabel *storyLabel;
@property (nonatomic,readonly) UILabel *statusLabel;
@property (nonatomic,readonly) UILabel *commentsLabel;
@property (nonatomic,retain) PivotalStory *story;

@end