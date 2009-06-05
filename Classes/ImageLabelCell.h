#import <UIKit/UIKit.h>


@interface ImageLabelCell : UITableViewCell {
@private 
    UIImageView* cellImage;
    UILabel* cellLabel;
}

@property (nonatomic,readonly) UIImageView* cellImage;
@property (nonatomic,readonly) UILabel* cellLabel;
@property (nonatomic,retain) UIImage* image;


@end
