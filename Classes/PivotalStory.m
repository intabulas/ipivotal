#import "PivotalStory.h"
#import "PivotalProject.h"

@implementation PivotalStory

@synthesize storyId, storyType, estimate, url, currentState, description, name, requestedBy, owner, createdAt, acceptedAt, comments, tasks;

#pragma mark -
#pragma mark Cleanup Methods

- (id)init {
    [super init];
    storyType = kTypeFeature;
    estimate = 0;
    name = kTextStoryNeedsName;
    description = kTextStoryDescription;
    comments = [[NSMutableArray alloc] init];
    tasks = [[NSMutableArray alloc] init];
    return self;
}

- (id)initWithStoryId:(NSInteger)theId {
    [self init];
    storyId = theId;
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<PivotalStory name:'%@' comments:'%d' tasks:'%d'>", name, [comments count], [tasks count]];
}

- (id)initWithStoryId:(NSInteger)theId andProject:(PivotalProject *)theProject {
  [self initWithStoryId:theId];
    project = [theProject retain];
  return self;
}

- (void)dealloc {
    if ( project != nil )  {
        [project release];
    }
    [comments release]; comments = nil;
    [tasks release]; tasks = nil;
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


- (void)loadStory {
	if (self.isSaving) return;
	NSString *saveURLString = [NSString stringWithFormat:kUrlUpdateStory,project.projectId, self.storyId];
	NSURL *saveURL = [NSURL URLWithString:saveURLString];
	self.error = nil;
	self.savingStatus = PivotalResourceStatusSaving;
	[self performSelectorInBackground:@selector(retrieveContentFromURL:) withObject:saveURL];
}


- (void)retrieveContentFromURL:(NSURL *)theURL {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	ASIHTTPRequest *request = [PivotalResource authenticatedRequestForURL:theURL];
    [request setRequestMethod:@"GET"];    
    [request addRequestHeader:kHttpContentType value:kHttpMimeTypeXml];
	[request start];
#ifdef LOG_NETWORK	
    NSLog(@"%@", [request responseString]);
#endif    
    self.savingStatus = PivotalResourceStatusSaved;
    
	[pool release];
}



@end
