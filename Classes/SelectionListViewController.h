#import <UIKit/UIKit.h>
#import "LabelCell.h"

@interface SelectionListViewController : UIViewController <UITableViewDelegate> {
    NSArray *selectionList;
  @private
    IBOutlet UITableView *selectionTableView;    
    IBOutlet LabelCell   *selectioCell;
}

@property (nonatomic,retain) NSArray *selectionList;


- (id)initWithObjects:(NSArray *)theList;

@end
