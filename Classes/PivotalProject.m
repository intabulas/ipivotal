#import "PivotalProject.h"


@implementation PivotalProject

@synthesize projectId, name, iterationLength, weekStartDay, pointScale;

#pragma mark -
#pragma mark Cleanup Methods

- (void)dealloc {
    [name release];
    [weekStartDay release];
    [pointScale release];
    [super dealloc];
}
@end
