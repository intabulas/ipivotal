#import <UIKit/UIKit.h>
#import "PivotalProject.h"
#import "PivotalStory.h"

@interface AddStoryViewController : UIViewController <UITableViewDelegate, UIAlertViewDelegate> {
    PivotalProject *project;
    PivotalStory* story;
    NSMutableDictionary *editingDictionary;
    id activeField;
    IBOutlet UITableView *storyTableView;       
    BOOL editing;
}

@property (nonatomic,retain) PivotalStory* story;
@property (nonatomic,retain) NSMutableDictionary *editingDictionary;

- (id)initWithProject:(PivotalProject *)theProject;
- (id)initWithProject:(PivotalProject *)theProject andStory:(PivotalStory *)theStory;

- (IBAction) saveStory:(id)sender;

@end
