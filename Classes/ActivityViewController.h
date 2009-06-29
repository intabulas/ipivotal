#import <UIKit/UIKit.h>
#import "PivotalActivities.h"


@interface ActivityViewController : UITableViewController {
	PivotalActivities *activities;
	IBOutlet UITableViewCell *loadingActivitiesCell;
	IBOutlet UITableViewCell *noActivitiesCell;
}


- (id)init;

- (IBAction)refresh:(id)sender;

@end
