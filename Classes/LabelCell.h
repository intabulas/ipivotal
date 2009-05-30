#import <UIKit/UIKit.h>

@interface LabelCell : UITableViewCell {
  @private
    IBOutlet UILabel *textLabel;
}

@property (nonatomic,retain) UILabel *textLabel;

@end
