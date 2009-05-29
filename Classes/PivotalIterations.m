
#import "PivotalIterations.h"
#import "PivotalIterationsParserDelegate.h"

@interface PivotalIterations ()
- (void)parseIterations;
- (void)fetchIterations;
@end

@implementation PivotalIterations

@synthesize url, iterations, cacheFilename, lastUpdated, project;

- (id)initWithProject:(PivotalProject *)theProject {
    [super init];
    self.project = theProject;
    self.url = [NSURL URLWithString:[NSString stringWithFormat:kUrlIterationList, [self.project projectId]]];
    self.cacheFilename = [NSString stringWithFormat:@"%d_iterations.xml", [self.project projectId]];
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<PivotalIterations url:'%@'>", url];
}

#pragma mark -
#pragma mark Loading methods

- (void)loadIterations {
    self.error = nil;
    self.status = PivotalResourceStatusLoading;
    [self performSelectorInBackground:@selector(loadRecords) withObject:nil];
}



- (void)loadedIterations:(id)theResult {
    if ( [theResult isKindOfClass:[NSError class]]) {
        self.error = theResult;
        self.status = PivotalResourceStatusNotLoaded;
    } else {
        self.iterations = theResult;
        self.status = PivotalResourceStatusLoaded;
    }
}

- (void)loadRecords {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];    
    if ([self hasCachedDocument]) {
        self.parseIterations;        
    } else {
        self.fetchIterations;
    }
    [pool release];    
}


- (void)reloadIterations {
	if (self.isLoading) return;
	self.error = nil;
	self.status = PivotalResourceStatusLoading;
	[self performSelectorInBackground:@selector(fetchIterations) withObject:nil];    
}

- (void)parseIterations {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    NSData *feed = [NSData dataWithContentsOfFile:[self pathForFile:cacheFilename]];
    self.lastUpdated = [self modificationTimeForFile:cacheFilename];
	PivotalIterationsParserDelegate *parserDelegate = [[PivotalIterationsParserDelegate alloc] initWithTarget:self andSelector:@selector(loadedIterations:)];
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

- (void)fetchIterations {
    
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    ASIHTTPRequest *request = [PivotalResource authenticatedRequestForURL:self.url];
	[request start];
    self.error = [request error];
    NSError *theError;    
    NSString *writeableFile = [self pathForFile:cacheFilename];
    NSLog(@"Response: '%@'", request.responseString );
    [request.responseString writeToFile:writeableFile atomically:YES encoding:NSUTF8StringEncoding  error:&theError];
    [self parseIterations];
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
    [iterations release];
    [cacheFilename release];
    [lastUpdated release];
    [project release];
    [super dealloc];
}

@end
