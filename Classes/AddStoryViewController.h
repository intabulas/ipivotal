#import <UIKit/UIKit.h>
#import "PivotalProject.h"
#import "PivotalStory.h"

@interface AddStoryViewController : UIViewController <UITableViewDelegate> {
    PivotalProject *project;
    PivotalStory* story;
    id activeField;
    @private
      IBOutlet UITableView *storyTableView;       
}

@property (nonatomic,retain) PivotalStory* story;

- (id)initWithProject:(PivotalProject *)theProject;


@end
