
#import "PivotalIterations.h"
#import "PivotalIterationsParserDelegate.h"

@interface PivotalIterations ()
- (void)parseIterations;
- (void)fetchIterations;
@end

@implementation PivotalIterations

@synthesize url, iterations, cacheFilename, lastUpdated, project, group;

- (id)initWithProject:(PivotalProject *)theProject {
    [super init];
    self.group = kTypeCurrent;
    self.project = theProject;
    self.url = [NSURL URLWithString:[NSString stringWithFormat:kUrlIterationTypeList, [self.project projectId], self.group]];
    self.cacheFilename = [NSString stringWithFormat:kCacheFileIterations, [self.project projectId]];
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<PivotalIterations url:'%@'>", url];
}

#pragma mark -
#pragma mark Loading methods

- (void)reloadInterationForGroup:(NSString*)theGroup {
    self.group = theGroup;
    self.url = [NSURL URLWithString:[NSString stringWithFormat:kUrlIterationTypeList, [self.project projectId], self.group]];
    self.cacheFilename = [NSString stringWithFormat:kCacheFileIterationsGrouped, [self.project projectId], self.group];
    
    [self loadIterations];
}

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
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    ASIHTTPRequest *request = [PivotalResource authenticatedRequestForURL:self.url];
	[request start];
    self.error = [request error];
    NSError *theError;    
    NSString *writeableFile = [self pathForFile:cacheFilename];
    [request.responseString writeToFile:writeableFile atomically:YES encoding:NSUTF8StringEncoding  error:&theError];
    [self parseIterations];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;    
	[pool release];    
}






#pragma mark -
#pragma mark Cached File Methods

- (BOOL)hasCachedDocument {
	return NO;
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    return [fileManager fileExistsAtPath:[self pathForFile:cacheFilename]];
}


#pragma mark === Cleanup ===

- (void)dealloc {
    [url release];
    [group release];
    [iterations release];
    [cacheFilename release];
    [lastUpdated release];
    [project release];
    [super dealloc];
    
}

@end
