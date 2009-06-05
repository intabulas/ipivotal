#import <UIKit/UIKit.h>
#import "PivotalIteration.h"

@interface IterationHeaderView : UIView {
@private
    UILabel* titleLabel;
    UILabel* dateLabel;
}

@property (nonatomic,readonly) UILabel* titleLabel;
@property (nonatomic,readonly) UILabel* dateLabel;

- (void) setIteration:(PivotalIteration*)iteration;

@end
