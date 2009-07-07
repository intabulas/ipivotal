#import "PivotalActivities.h"
#import "PivotalActivityParserDelegate.h"
#import "PivotalProject.h"

@interface PivotalActivities ()
- (void)parseActivities;
- (void)fetchActivities;
@end

@implementation PivotalActivities

@synthesize activities, cacheFilename, url, lastUpdated;	

- (id)init {
	[super init];
    self.cacheFilename = [NSString stringWithFormat:kCacheActivityStream];
	self.url = [NSURL URLWithString:kUrlActivityStream];
	return self;
}

- (id)initWithProject:(PivotalProject *)theProject {
     [self init];
     if ( theProject ) {
       self.url = [NSURL URLWithString:[NSString stringWithFormat:kUrlProjectActivityStream, theProject.projectId ]];
       self.cacheFilename = [NSString stringWithFormat:kCacheProjectActivityStream, theProject.projectId];
     }
     return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<PivotalActivities url:'%@'>", url];
}

#pragma mark -
#pragma mark Loading methods

- (void)loadActivities {
    self.error = nil;
    self.status = PivotalResourceStatusLoading;
    [self performSelectorInBackground:@selector(loadRecords) withObject:nil];
}



- (void)loadedActivities:(id)theResult {
    if ( [theResult isKindOfClass:[NSError class]]) {
        self.error = theResult;
        self.status = PivotalResourceStatusNotLoaded;
    } else {
        self.activities = theResult;
        self.status = PivotalResourceStatusLoaded;
    }
}

- (void)loadRecords {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];    
    if ([self hasCachedDocument]) {
        self.parseActivities;        
    } else {
        self.fetchActivities;
    }
    [pool release];    
}


- (void)reloadActivities {
	if (self.isLoading) return;
	self.error = nil;
	self.status = PivotalResourceStatusLoading;
	[self performSelectorInBackground:@selector(fetchActivities) withObject:nil];    
}

- (void)parseActivities {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    NSData *feed = [NSData dataWithContentsOfFile:[self pathForFile:cacheFilename]];
    self.lastUpdated = [self modificationTimeForFile:cacheFilename];
	PivotalActivityParserDelegate *parserDelegate = [[PivotalActivityParserDelegate alloc] initWithTarget:self andSelector:@selector(loadedActivities:)];
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

- (void)fetchActivities {
    
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;    
    ASIHTTPRequest *request = [PivotalResource authenticatedRequestForURL:self.url];
	[request start];
    self.error = [request error];
    NSError *theError;    
    NSString *writeableFile = [self pathForFile:cacheFilename];
    [request.responseString writeToFile:writeableFile atomically:YES encoding:NSUTF8StringEncoding  error:&theError];
    [self parseActivities];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;    
	[pool release];    
}



#pragma mark -
#pragma mark Cached File Methods

- (BOOL)hasCachedDocument {
#ifdef CACHED_CONTENT	
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:[self pathForFile:cacheFilename]];
#else
	return NO;
#endif
}


#pragma mark === Cleanup ===

- (void)dealloc {
	[activities release];
    [url release];
    [cacheFilename release];
    [lastUpdated release];
    [super dealloc];
}

@end
