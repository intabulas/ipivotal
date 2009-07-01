#import "PivotalStories.h"
#import "PivotalStoriesParserDelegate.h"

@interface PivotalStories ()
- (void)parseStories;
- (void)fetchStories;
@end

@implementation PivotalStories

@synthesize url, stories, cacheFilename, lastUpdated, storyType;

- (id)initWithProject:(PivotalProject *)theProject andType:(NSString *)theType {
    [super init];
    project = theProject;
    self.cacheFilename = [NSString stringWithFormat:kCacheFileStories, theProject.name, theType];
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
    if ([self hasCachedDocument]) {
        self.parseStories;        
    } else {
        self.fetchStories;
    }
    [pool release];    
}


- (void)reloadStories {
	if (self.isLoading) return;
	self.error = nil;
	self.status = PivotalResourceStatusLoading;
	[self performSelectorInBackground:@selector(fetchStories) withObject:nil];    
}

- (void)parseStories {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    NSData *feed = [NSData dataWithContentsOfFile:[self pathForFile:cacheFilename]];
    self.lastUpdated = [self modificationTimeForFile:cacheFilename];
	PivotalStoriesParserDelegate *parserDelegate = [[PivotalStoriesParserDelegate alloc] initWithTarget:self andSelector:@selector(loadedStories:)];
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:feed];
	[parser setDelegate:parserDelegate];
	[parser setShouldProcessNamespaces:NO];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];
	[parser parse];
	[parser release];
	[parserDelegate release];
	[pool release];    
}

- (void)fetchStories {
    
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;    
    ASIHTTPRequest *request = [PivotalResource authenticatedRequestForURL:self.url];
	[request start];
    self.error = [request error];
    NSError *theError;    
    NSString *writeableFile = [self pathForFile:cacheFilename];
    [request.responseString writeToFile:writeableFile atomically:YES encoding:NSUTF8StringEncoding  error:&theError];
    [self parseStories];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[pool release];    
}






#pragma mark -
#pragma mark Cached File Methods

- (BOOL)hasCachedDocument {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:[self pathForFile:cacheFilename]];
}


#pragma mark === Cleanup ===

- (void)dealloc {
    [url release];
    [stories release];
    [project release];
    [cacheFilename release];
    [lastUpdated release];
    [super dealloc];
}

@end
