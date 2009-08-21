#import "PivotalNote.h"
#import "ASIHTTPRequest.h"
#import "PivotalStory.h"
#import "PivotalProject.h"

@interface PivotalNote ()
- (void)sendCommentDataToURL:(NSURL *)theURL;
- (void)receiveCommentData:(id)theResult;
@end


@implementation PivotalNote
@synthesize noteId, text, author, createdAt, visualHeight;

-(id)initWithProject:(PivotalProject *)theProject andStory:(PivotalStory *)theStory {
    [super init];
    project = theProject;
    story = theStory;
    return self;
}



-(void)dealloc {
    [text release]; text= nil;
    [author release]; author = nil;
    [createdAt release]; createdAt = nil;
    [super dealloc];
}


- (NSString *)to_xml {
   return [NSString stringWithFormat:kXmlAddComment, text];            
}



- (void)receiveCommentData:(id)theResult {
}

- (void)saveNote{
	if (self.isSaving) return;
	NSString *saveURLString = [NSString stringWithFormat:kUrlAddComment,project.projectId, story.storyId];
	NSURL *saveURL = [NSURL URLWithString:saveURLString];
	self.error = nil;
	self.savingStatus = PivotalResourceStatusSaving;
	[self performSelectorInBackground:@selector(sendCommentDataToURL:) withObject:saveURL];
}


- (void)sendCommentDataToURL:(NSURL *)theURL {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	ASIHTTPRequest *request = [PivotalResource authenticatedRequestForURL:theURL];
    
    NSString *newcomment = [self to_xml];
    [request addRequestHeader:kHttpContentType value:kHttpMimeTypeXml];
    [request setPostBody:[[NSMutableData alloc] initWithData:[newcomment dataUsingEncoding:NSUTF8StringEncoding]]];
	[request start];
	
    NSLog(@"%@", [request responseString]);
    self.savingStatus = PivotalResourceStatusSaved;
    
	[pool release];
}


@end
