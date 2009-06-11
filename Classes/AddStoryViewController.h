#import <UIKit/UIKit.h>
#import "PivotalProject.h"
#import "PivotalStory.h"

@interface AddStoryViewController : UIViewController <UITableViewDelegate> {
    PivotalProject *project;
    PivotalStory* story;
    NSMutableDictionary *editingDictionary;
    id activeField;
    @private
      IBOutlet UITableView *storyTableView;       
}

@property (nonatomic,retain) PivotalStory* story;
@property (nonatomic,retain) NSMutableDictionary *editingDictionary;
- (id)initWithProject:(PivotalProject *)theProject;


- (IBAction) saveStory:(id)sender;

@end
