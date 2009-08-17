#import <UIKit/UIKit.h>
#import "PivotalProject.h"
#import "PivotalIterations.h"

@interface IterationsViewController :  UIViewController <UITableViewDelegate>  {
    @private
    PivotalProject *project;
    PivotalIterations *iterations;
    IBOutlet UITableView *iterationTableView;    
    IBOutlet UIBarButtonItem *doneStoriesButton;
    NSInteger lastIterationType;
}
@property (nonatomic,retain) IBOutlet UITableView *iterationTableView;
@property (nonatomic,retain) PivotalProject* project;

- (id)initWithProject:(PivotalProject *)theProject;
- (IBAction)refresh:(id)sender;
- (void)loadIterations;

-(IBAction)showDoneStories:(id)sender;
-(IBAction)showIceboxStories:(id)sender;
-(IBAction)addStory:(id)sender;
-(IBAction)projectActivity:(id)sender;

- (void) iterationTypeChanged:(id)sender;

@end
