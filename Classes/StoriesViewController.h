#import <UIKit/UIKit.h>
#import "PivotalStories.h"

@class PivotalProject;

@interface StoriesViewController :  UIViewController <UITableViewDelegate>  {
@private
    PivotalProject *project;
    PivotalStories *stories;
    NSString *storyType;
    IBOutlet UITableView *storiesTableView;    
	IBOutlet UIView *updatedHeaderView;
	IBOutlet UILabel *lastUpdatedLabel;       
}

@property (nonatomic,retain) IBOutlet UITableView *storiesTableView;

- (id)initWithProject:(PivotalProject *)theProject andType:(NSString *)theType;
- (IBAction)refresh:(id)sender;
- (void)loadStories;
- (IBAction)addStory:(id)sender;

@end
