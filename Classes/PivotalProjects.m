#import "PivotalProjects.h"
#import "PivotalProjectsParserDelegate.h"

@interface PivotalProjects ()
- (void)fetchProjects;
@end

@implementation PivotalProjects

@synthesize url, projects;

- (id)init {
    [super init];
    self.url = [NSURL URLWithString:kUrlProjectList];
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
        self.fetchProjects;
    [pool release];    
}


- (void)reloadProjects {
	if (self.isLoading) return;
	self.error = nil;
	self.status = PivotalResourceStatusLoading;
	[self performSelectorInBackground:@selector(fetchProjects) withObject:nil];    
}


- (void)fetchProjects {

	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;    
    ASIHTTPRequest *request = [PivotalResource authenticatedRequestForURL:self.url];
	[request start];
    self.error = [request error];
	PivotalProjectsParserDelegate *parserDelegate = [[PivotalProjectsParserDelegate alloc] initWithTarget:self andSelector:@selector(loadedProjects:)];
#ifdef LOG_NETWORK    
    NSLog(@"%@", [request responseString]);
#endif
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
    [projects release];
    [super dealloc];
}

@end
