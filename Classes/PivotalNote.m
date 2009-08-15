#import "PivotalNote.h"

@implementation PivotalNote
@synthesize noteId, text, author, createdAt;

- (id)init {
    [super init];
    return self;
}

-(void)dealloc {
    [text release]; text= nil;
    [author release]; author = nil;
    [createdAt release]; createdAt = nil;
    [super dealloc];
}

@end
