#import "LabelCell.h"


@implementation LabelCell

@synthesize textLabel;

- (void)dealloc {
    [textLabel dealloc];
    [super dealloc];
}


@end
