
#import <UIKit/UIKit.h>
#import "PivotalNote.h"

@interface CommentHeaderView : UIView {
@private
    UIImageView* commentImage;
    UILabel* commentTitle;
}

@property (nonatomic,readonly) UIImageView* commentImage;
@property (nonatomic,readonly) UILabel* commentTitle;

- (void) setNote:(PivotalNote *)note;

@end
