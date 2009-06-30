#import <UIKit/UIKit.h>
#import "PivotalActivities.h"
#import "PivotalProject.h"

@interface ActivityViewController : UITableViewController {
	PivotalActivities *activities;
    PivotalProject *project;
	IBOutlet UITableViewCell *loadingActivitiesCell;
	IBOutlet UITableViewCell *noActivitiesCell;
	IBOutlet UIView *updatedHeaderView;
	IBOutlet UILabel *lastUpdatedLabel;    
}


- (id)init;
- (id)initWithProject:(PivotalProject *)theProject;
- (IBAction)refresh:(id)sender;

@end
