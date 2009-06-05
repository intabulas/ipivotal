#import <UIKit/UIKit.h>
#import "PivotalProjects.h"

@interface ProjectsViewController : UIViewController <UITableViewDelegate> {
@private    
    IBOutlet UITableView *projectTableView;
    IBOutlet UITableViewCell *loadingProjectsCell;
    IBOutlet UITableViewCell *noProjectsCell;
    PivotalProjects *projects;    
}

@property (nonatomic,retain) IBOutlet UITableView *projectTableView;

- (IBAction)logout:(id)sender;
- (IBAction)refresh:(id)sender;

- (void)loadProjects;

@end
