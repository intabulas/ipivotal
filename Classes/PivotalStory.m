#import "PivotalStory.h"


@implementation PivotalStory

@synthesize storyId, storyType, estimate, url, currentState, description, name, requestedBy, owner, createdAt, acceptedAt;

#pragma mark -
#pragma mark Cleanup Methods

- (id)init {
    [super init];
    storyType = @"Feature";
    estimate = 2;
    name = @"please give this story a title";
    description = @"please give this story a description";
    return self;
}
- (void)dealloc {
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
//    return [NSString stringWithFormat:@"<story><story_type>%@</story_type><name>%@</name><estimate>%d</estimate></story>", [storyType lowercaseString], name, estimate];
    return [NSString stringWithFormat:@"<story><story_type>%@</story_type><name>%@</name></story>", [storyType lowercaseString], name];
    
}


@end
