#import "PivotalActivities.h"
#import "PivotalActivityParserDelegate.h"
#import "PivotalProject.h"

@interface PivotalActivities ()
- (void)fetchActivities;
@end

@implementation PivotalActivities

@synthesize activities, url;	

- (id)init {
	[super init];
	self.url = [NSURL URLWithString:kUrlActivityStream];
	return self;
}

- (id)initWithProject:(PivotalProject *)theProject {
     [self init];
     if ( theProject ) {
       self.url = [NSURL URLWithString:[NSString stringWithFormat:kUrlProjectActivityStream, theProject.projectId ]];
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
        self.fetchActivities;
    [pool release];    
}


- (void)reloadActivities {
	if (self.isLoading) return;
	self.error = nil;
	self.status = PivotalResourceStatusLoading;
	[self performSelectorInBackground:@selector(fetchActivities) withObject:nil];    
}

- (void)fetchActivities {
    
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;    
    ASIHTTPRequest *request = [PivotalResource authenticatedRequestForURL:self.url];
	[request start];
    self.error = [request error];
#ifdef LOG_NETWORK    
    NSLog(@"Activities: '%@'", [request responseString]);
#endif    

    PivotalActivityParserDelegate *parserDelegate = [[PivotalActivityParserDelegate alloc] initWithTarget:self andSelector:@selector(loadedActivities:)];
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
	[activities release];
    [url release];
    [super dealloc];
}

@end
