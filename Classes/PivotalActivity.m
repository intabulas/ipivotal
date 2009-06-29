
#import "PivotalActivity.h"


@implementation PivotalActivity

@synthesize activityId, project, story, description, author, when;

- (id)init {
    [super init];
    return self;
}
- (void)dealloc {
    [project release];
    [story release];
    [description release];
    [author release];
    [when release];
    [super dealloc];
}

@end
