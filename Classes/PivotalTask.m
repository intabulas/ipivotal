
#import "PivotalTask.h"
#import "ASIHTTPRequest.h"
#import "PivotalStory.h"
#import "PivotalProject.h"
#import "PivotalNoteParserDelegate.h"

@interface PivotalTask ()
@end


@implementation PivotalTask
@synthesize taskId, description, position, complete, createdAt;

-(id)initWithProject:(PivotalProject *)theProject andStory:(PivotalStory *)theStory {
    [super init];
    project = theProject;
    story = theStory;
    return self;
}



-(void)dealloc {
    [description release]; description = nil;
    [createdAt release]; createdAt = nil;
    [super dealloc];
}




@end
