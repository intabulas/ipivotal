#import <UIKit/UIKit.h>
#import "PivotalProjects.h"
#import "ProjectCell.h"

@interface ProjectsViewController : UIViewController <UITableViewDelegate> {
    @private
    
    IBOutlet UITableView *projectTableView;
    IBOutlet UITableViewCell *loadingProjectsCell;
    IBOutlet UITableViewCell *noProjectsCell;
    IBOutlet ProjectCell *projectCell;
    PivotalProjects *projects;    
}

@property (nonatomic,retain) IBOutlet UITableView *projectTableView;

- (IBAction)logout:(id)sender;
- (IBAction)refresh:(id)sender;

- (void)loadProjects;

@end
