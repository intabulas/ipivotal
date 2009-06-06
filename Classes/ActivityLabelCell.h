
#import <UIKit/UIKit.h>

@interface ActivityLabelCell : UITableViewCell {
@private 
    UILabel* cellLabel;
    UIActivityIndicatorView* activityView;
}

@property (nonatomic,readonly) UILabel* cellLabel;
@property (nonatomic,readonly) UIActivityIndicatorView* activityView;

@end
