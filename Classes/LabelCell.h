#import <UIKit/UIKit.h>

@interface LabelCell : UITableViewCell {
@private 
    UILabel* cellLabel;
}

@property (nonatomic,readonly) UILabel* cellLabel;

@end
