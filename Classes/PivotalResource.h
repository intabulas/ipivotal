#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

typedef enum {
    PivotalResourceStatusNotLoaded = 0,
    PivotalResourceStatusLoading = 1,
    PivotalResourceStatusLoaded = 2    
} PivotalResourceStatus;

@interface PivotalResource : NSObject {
    PivotalResourceStatus status;

    NSError *error;
}

@property (nonatomic,retain) NSError *error;
@property (nonatomic, readwrite) PivotalResourceStatus status;
@property (nonatomic, readonly) BOOL isLoaded;
@property (nonatomic, readonly) BOOL isLoading;

+(ASIHTTPRequest *)authenticatedRequestForURL:(NSURL *)theUrl;

- (NSString *)pathForFile:(NSString *)filename;
- (NSDate *)modificationTimeForFile:(NSString *)filename ;


@end
