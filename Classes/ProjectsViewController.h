#import <UIKit/UIKit.h>
#import "PivotalProjects.h"

@interface ProjectsViewController : UIViewController <UITableViewDelegate> {    
    IBOutlet UITableView *projectTableView;
    IBOutlet UITableViewCell *loadingProjectsCell;
    IBOutlet UITableViewCell *noProjectsCell;
    PivotalProjects *projects;    
	IBOutlet UIView *updatedHeaderView;
	IBOutlet UILabel *lastUpdatedLabel;          
}

@property (nonatomic,retain) IBOutlet UITableView *projectTableView;

- (IBAction)logout:(id)sender;
- (IBAction)refresh:(id)sender;
- (IBAction)recentActivity:(id)sender;


- (void)loadProjects;
- (void)reloadProjects;
@end
