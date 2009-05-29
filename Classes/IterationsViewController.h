#import <UIKit/UIKit.h>
#import "PivotalProject.h"
#import "PivotalIterations.h"
#import "StoryCell.h"

@interface IterationsViewController :  UIViewController <UITableViewDelegate>  {
    @private
    PivotalProject *project;
    PivotalIterations *iterations;
    IBOutlet UITableViewCell *loadingCell;
    IBOutlet UITableViewCell *noIterationsCell; 
    IBOutlet StoryCell *storyCell;     
    IBOutlet UITableView *iterationTableView;    
}
@property (nonatomic,retain) IBOutlet UITableView *iterationTableView;

- (id)initWithProject:(PivotalProject *)theProject;
- (IBAction)refresh:(id)sender;
- (void)loadIterations;

@end
