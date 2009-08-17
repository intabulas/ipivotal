#import "PivotalStories.h"
#import "PivotalStoriesParserDelegate.h"

@interface PivotalStories ()
- (void)fetchStories;
@end

@implementation PivotalStories

@synthesize url, stories, storyType;

- (id)initWithProject:(PivotalProject *)theProject andType:(NSString *)theType {
    [super init];
    project = theProject;
    self.storyType = theType;
    NSString *storiesURL ;
    if ( [theType hasPrefix:kTypeIcebox] ) {
        storiesURL = [NSString stringWithFormat:kUrlIceboxStories, project.projectId];        
    } else {
       storiesURL = [NSString stringWithFormat:kUrlIterationTypeList, project.projectId, theType];
    }
    self.url = [NSURL URLWithString:storiesURL];
    return self;
}
- (NSString *)description {
    return [NSString stringWithFormat:@"<PivotalStories url:'%@'>", url];
}

#pragma mark -
#pragma mark Loading methods

- (void)loadStories {
    self.error = nil;
    self.status = PivotalResourceStatusLoading;
    [self performSelectorInBackground:@selector(loadRecords) withObject:nil];
}



- (void)loadedStories:(id)theResult {
    if ( [theResult isKindOfClass:[NSError class]]) {
        self.error = theResult;
        self.status = PivotalResourceStatusNotLoaded;
    } else {
        self.stories = theResult;
        self.status = PivotalResourceStatusLoaded;
    }
}

- (void)loadRecords {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];    
     self.fetchStories;
    [pool release];    
}


- (void)reloadStories {
	if (self.isLoading) return;
	self.error = nil;
	self.status = PivotalResourceStatusLoading;
	[self performSelectorInBackground:@selector(fetchStories) withObject:nil];    
}


- (void)fetchStories {
    
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;    
    ASIHTTPRequest *request = [PivotalResource authenticatedRequestForURL:self.url];
	[request start];
    self.error = [request error];
    NSError *theError;    

#ifdef LOG_NETWORK
    NSLog(@"Stories: '%@'", [request responseString]);
#endif    

	PivotalStoriesParserDelegate *parserDelegate = [[PivotalStoriesParserDelegate alloc] initWithTarget:self andSelector:@selector(loadedStories:)];
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:[request responseData]];
	[parser setDelegate:parserDelegate];
	[parser setShouldProcessNamespaces:NO];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];
	[parser parse];
	[parser release];
	[parserDelegate release];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[pool release];    
}






#pragma mark === Cleanup ===

- (void)dealloc {
    [url release];
    [stories release];
    [project release];
    [super dealloc];
}

@end
