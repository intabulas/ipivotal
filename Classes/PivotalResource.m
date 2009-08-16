#import "PivotalResource.h"
#import "ASIHTTPRequest.h"

@implementation PivotalResource

@synthesize status, error;

- (id)init {
	[super init];
	self.status = PivotalResourceStatusNotLoaded;
    return self;
}

- (BOOL)isLoading {
	return status == PivotalResourceStatusLoading;
}

- (BOOL)isLoaded {
	return status == PivotalResourceStatusLoaded;
}


- (void) dealloc {
	[error release];
	[super dealloc];
}


#pragma mark === Cached Files methods ===

- (NSString *)pathForFile:(NSString *)filename {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return  [documentsDirectory stringByAppendingPathComponent:filename];    
}

- (NSDictionary *)attributesForFile:(NSString *)filename {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullFilename =  [documentsDirectory stringByAppendingPathComponent:filename];    
    return [fileManager fileAttributesAtPath:fullFilename traverseLink:NO ];
}

- (NSDate *)modificationTimeForFile:(NSString *)filename {
    NSDictionary *attributes = [self attributesForFile:filename];
    return (NSDate *)[attributes objectForKey:NSFileModificationDate];
    
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
