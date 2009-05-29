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
    IBOutlet UIBarButtonItem *doneStoriesButton;
    
}
@property (nonatomic,retain) IBOutlet UITableView *iterationTableView;

- (id)initWithProject:(PivotalProject *)theProject;
- (IBAction)refresh:(id)sender;
- (void)loadIterations;

-(IBAction)showDoneStories:(id)sender;
-(IBAction)showIceboxStories:(id)sender;


@end
