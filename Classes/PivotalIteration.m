#import "PivotalIteration.h"


@implementation PivotalIteration
@synthesize iterationId, iterationNumber, startDate, endDate, stories;

#pragma mark -
#pragma mark Cleanup Methods

- (id)init {
    stories = [[NSMutableArray alloc] init];
    return self;
}

- (void)dealloc {
    
    [startDate release];
    [endDate release];    
    [stories release];
    [super dealloc];
    
}

@end
