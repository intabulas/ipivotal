#import "PivotalStory.h"


@implementation PivotalStory

@synthesize storyId, storyType, estimate, url, currentState, description, name, requestedBy, owner, createdAt, acceptedAt, comments;

#pragma mark -
#pragma mark Cleanup Methods

- (id)init {
    [super init];
    storyType = kTypeFeature;
    estimate = 0;
    name = kTextStoryNeedsName;
    description = @"please give this story a description";
    comments = [[NSMutableArray alloc] init];
    return self;
}

- (void)dealloc {
    [comments release];
    [storyType release];
    [url release];
    [currentState release];
    [description release];
    [name release];
    [requestedBy release];
    [owner release];
    [createdAt release];
    [acceptedAt release];    
    [super dealloc];
}

- (NSString *)to_xml {
    if ([storyType hasPrefix:kTypeFeature]) {
        return [NSString stringWithFormat:kXmlAddStoryFeature, [storyType lowercaseString], name, estimate];            
    } else {
        return [NSString stringWithFormat:kXmlAddStory, [storyType lowercaseString], name];    
    }
}


@end
