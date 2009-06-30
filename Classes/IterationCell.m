
#import "IterationCell.h"
#import "PivotalIteration.h"
#import "NSDate+Nibware.h"

@implementation IterationCell

@synthesize iteration;

- (void)setIteration:(PivotalIteration *)anIteration {
	[iteration release];
	iteration = [anIteration retain];
	name.text = [NSString stringWithFormat:@"%d", iteration.iterationNumber];
    dateRange.text = kEmptyString;
}


- (void)dealloc {
    [iteration release];    
    [name release];    
    [dateRange release]; 
    [icon release];
    [super dealloc];
}


@end
