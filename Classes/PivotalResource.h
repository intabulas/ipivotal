#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

typedef enum {
	PivotalResourceStatusNotSaved = 0,
	PivotalResourceStatusSaving = 1,
	PivotalResourceStatusSaved = 2
} PivotalResourceSavingStatus;


typedef enum {
    PivotalResourceStatusNotLoaded = 0,
    PivotalResourceStatusLoading = 1,
    PivotalResourceStatusLoaded = 2    
} PivotalResourceStatus;


@interface PivotalResource : NSObject {
    PivotalResourceStatus status;
    PivotalResourceSavingStatus savingStatus;
    NSError *error;
}

@property (nonatomic,retain) NSError *error;
@property (nonatomic, readwrite) PivotalResourceStatus status;

@property (nonatomic, readwrite) PivotalResourceSavingStatus savingStatus;

@property (nonatomic, readonly) BOOL isLoaded;
@property (nonatomic, readonly) BOOL isLoading;
@property (nonatomic, readonly) BOOL isSaved;
@property (nonatomic, readonly) BOOL isSaving;

+(ASIHTTPRequest *)authenticatedRequestForURL:(NSURL *)theUrl;

@end
