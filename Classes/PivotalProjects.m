#import "PivotalProjects.h"
#import "PivotalProjectsParserDelegate.h"

@interface PivotalProjects ()
- (void)parseProjects;
- (void)fetchProjects;
@end

@implementation PivotalProjects

@synthesize url, projects, cacheFilename, lastUpdated;

- (id)init {
    [super init];
    self.url = [NSURL URLWithString:kUrlProjectList];
    self.cacheFilename = [NSString stringWithString:@"projects.xml"];
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<PivotalProjects url:'%@'>", url];
}

#pragma mark -
#pragma mark Loading methods

- (void)loadProjects {
    self.error = nil;
    self.status = PivotalResourceStatusLoading;
    [self performSelectorInBackground:@selector(loadRecords) withObject:nil];
}



- (void)loadedProjects:(id)theResult {
    if ( [theResult isKindOfClass:[NSError class]]) {
        self.error = theResult;
        self.status = PivotalResourceStatusNotLoaded;
    } else {
        self.projects = theResult;
        self.status = PivotalResourceStatusLoaded;
    }
}

- (void)loadRecords {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];    
//    if ([self hasCachedDocument]) {
//        self.parseProjects;        
//    } else {
        self.fetchProjects;
//    }
    [pool release];    
}


- (void)reloadProjects {
	if (self.isLoading) return;
	self.error = nil;
	self.status = PivotalResourceStatusLoading;
	[self performSelectorInBackground:@selector(fetchProjects) withObject:nil];    
}

- (void)parseProjects {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    NSData *feed = [NSData dataWithContentsOfFile:[self pathForFile:cacheFilename]];
    self.lastUpdated = [self modificationTimeForFile:cacheFilename];
	PivotalProjectsParserDelegate *parserDelegate = [[PivotalProjectsParserDelegate alloc] initWithTarget:self andSelector:@selector(loadedProjects:)];
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

- (void)fetchProjects {

	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    ASIHTTPRequest *request = [PivotalResource authenticatedRequestForURL:self.url];
	[request start];
    self.error = [request error];
    NSError *theError;    
    NSString *writeableFile = [self pathForFile:cacheFilename];
    [request.responseString writeToFile:writeableFile atomically:YES encoding:NSUTF8StringEncoding  error:&theError];
    [self parseProjects];
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
    [projects release];
    [cacheFilename release];
    [lastUpdated release];
    [super dealloc];
}

@end
