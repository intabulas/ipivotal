#import <UIKit/UIKit.h>


@interface ListSelectionController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSArray *listItems;
    NSString *key;
    NSMutableDictionary *editingItem;
    UITableView *listTableView;
}

@property (nonatomic,retain) NSArray *listItems;
@property (nonatomic,retain) NSMutableDictionary *editingItem;
@property (nonatomic,retain) IBOutlet UITableView *listTableView;

- (id)initWithKey:(NSString *)theKey andTitle:(NSString *)theTitle;

@end
