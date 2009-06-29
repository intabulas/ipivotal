#import <UIKit/UIKit.h>
#import "PivotalActivity.h"

@interface ActivityItemCell : UITableViewCell {
	PivotalActivity *activity;
@private
	UILabel*     activityLabel;
	UILabel*     statusLabel;
	
}

@property (nonatomic,readonly) UILabel* activityLabel;
@property (nonatomic,readonly) UILabel* statusLabel;
@property (nonatomic,retain) PivotalActivity *activity;

@end