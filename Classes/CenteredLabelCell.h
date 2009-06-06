#import <UIKit/UIKit.h>

@interface CenteredLabelCell : UITableViewCell {
@private 
    UILabel* cellLabel;
}

@property (nonatomic,readonly) UILabel* cellLabel;

@end
