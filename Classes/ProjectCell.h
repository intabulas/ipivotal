#import <UIKit/UIKit.h>
#import "PivotalProject.h"

@interface ProjectCell : UITableViewCell {
    PivotalProject *project;
    @private
    IBOutlet UIImageView *projectIcon;
    IBOutlet UILabel     *projectName;
}

@property (nonatomic,retain) PivotalProject *project;

@end
