#import <UIKit/UIKit.h>
#import "PivotalStories.h"
#import "PivotalProject.h"
#import "IterationStoryCell.h"

@interface StoriesViewController :  UIViewController <UITableViewDelegate>  {
@private
    PivotalProject *project;
    PivotalStories *stories;
    NSString *storyType;
    IBOutlet UITableViewCell *loadingCell;
    IBOutlet UITableViewCell *noneCell; 
    IBOutlet IterationStoryCell *storyCell;     
    IBOutlet UITableView *storiesTableView;    
}
@property (nonatomic,retain) IBOutlet UITableView *storiesTableView;

- (id)initWithProject:(PivotalProject *)theProject andType:(NSString *)theType;
- (IBAction)refresh:(id)sender;
- (void)loadStories;
- (IBAction)addStory:(id)sender;

@end
