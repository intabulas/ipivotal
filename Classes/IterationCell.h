
#import <Foundation/Foundation.h>
#import "PivotalIteration.h"

@interface IterationCell : UITableViewCell {
    PivotalIteration *iteration;
    @private 
      IBOutlet UIImageView *icon;
      IBOutlet UILabel *name;    
      IBOutlet UILabel *dateRange;    
}

@property (nonatomic,retain) PivotalIteration *iteration;

@end
