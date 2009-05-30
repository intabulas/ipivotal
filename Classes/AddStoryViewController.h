#import <UIKit/UIKit.h>
#import "PivotalProject.h"

@interface AddStoryViewController : UIViewController <UITableViewDelegate> {
    PivotalProject *project;
    @private
      IBOutlet UITableView *storyTableView;
       
      IBOutlet UITableViewCell *nameCell;
      IBOutlet UITableViewCell *typeCell;    
      IBOutlet UITableViewCell *estimateCell;
      IBOutlet UITableViewCell *stateCell;
      IBOutlet UITableViewCell *descriptionCell;    
}

- (id)initWithProject:(PivotalProject *)theProject;


@end
