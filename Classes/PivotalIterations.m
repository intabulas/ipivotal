
#import "PivotalIterations.h"
#import "PivotalIterationsParserDelegate.h"

@interface PivotalIterations ()
- (void)fetchIterations;
@end

@implementation PivotalIterations

@synthesize url, iterations, project, group;

- (id)initWithProject:(PivotalProject *)theProject {
    [super init];
    self.group = kTypeCurrent;
    self.project = theProject;
    self.url = [NSURL URLWithString:[NSString stringWithFormat:kUrlIterationTypeList, [self.project projectId], self.group]];
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
        self.fetchIterations;
    [pool release];    
}


- (void)reloadIterations {
	if (self.isLoading) return;
	self.error = nil;
	self.status = PivotalResourceStatusLoading;
	[self performSelectorInBackground:@selector(fetchIterations) withObject:nil];    
}

- (void)fetchIterations {    
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    ASIHTTPRequest *request = [PivotalResource authenticatedRequestForURL:self.url];
	[request start];
    self.error = [request error];


	PivotalIterationsParserDelegate *parserDelegate = [[PivotalIterationsParserDelegate alloc] initWithTarget:self andSelector:@selector(loadedIterations:)];
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:[request responseData]];
	[parser setDelegate:parserDelegate];
	[parser setShouldProcessNamespaces:NO];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];
	[parser parse];
	[parser release];
	[parserDelegate release];
    

#ifdef LOG_NETWORK    
    NSLog(@"Iterations: '%@'", [request responseString]);
#endif    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;    
	[pool release];    
}




#pragma mark === Cleanup ===

- (void)dealloc {
    [url release];
    [group release];
    [iterations release];
    [project release];
    [super dealloc];
    
}

@end
