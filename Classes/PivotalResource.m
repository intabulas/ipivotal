#import "PivotalResource.h"
#import "ASIHTTPRequest.h"

@implementation PivotalResource

@synthesize status, error, savingStatus;

- (id)init {
	[super init];
	self.status = PivotalResourceStatusNotLoaded;
    self.savingStatus = PivotalResourceStatusNotSaved;
    return self;
}

- (BOOL)isLoading {
	return status == PivotalResourceStatusLoading;
}

- (BOOL)isLoaded {
	return status == PivotalResourceStatusLoaded;
}

- (BOOL)isSaving {
	return savingStatus == PivotalResourceStatusSaving;
}

- (BOOL)isSaved {
	return savingStatus ==PivotalResourceStatusSaved;
}


- (void) dealloc {
	[error release];
	[super dealloc];
}


#pragma mark === HTTP Authentication Methods ===

+(ASIHTTPRequest *)authenticatedRequestForURL:(NSURL *)theURL {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults stringForKey:kDefaultsApiToken];
    ASIHTTPRequest *request = [[[ASIHTTPRequest alloc] initWithURL:theURL] autorelease];
#ifdef NO_COMPRESS_RESPONSE    
    [request setAllowCompressedResponse:NO];
    [request setShouldCompressRequestBody:NO];
#endif    
    [request addRequestHeader:kTrackerTokenHeader value:token];
    return request;
}

@end
