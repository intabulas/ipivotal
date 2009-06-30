#import <UIKit/UIKit.h>
#import "PivotalActivity.h"

@interface ActivityItemCell : UITableViewCell {
	PivotalActivity *activity;
@private
    UIImageView* typeImage;    
	UILabel      *activityLabel;
	UILabel      *statusLabel;
    UILabel      *storyLabel;
	
}

@property (nonatomic,readonly) UILabel *activityLabel;
@property (nonatomic,readonly) UILabel *statusLabel;
@property (nonatomic,readonly) UILabel *storyLabel;
@property (nonatomic,retain) PivotalActivity *activity;
@property (nonatomic,readonly) UIImageView* typeImage;

@end