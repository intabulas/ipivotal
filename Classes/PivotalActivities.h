#import <Foundation/Foundation.h>
#import "PivotalResource.h"

@class PivotalProject;

@interface PivotalActivities : PivotalResource {
	NSArray *activities;
    NSString *cacheFilename;   
    NSURL *url;	
NSDate *lastUpdated;    	
}

@property (nonatomic,retain) NSURL *url;
@property (nonatomic,retain) NSArray *activities;
@property (nonatomic, retain) NSString *cacheFilename;
@property (nonatomic, retain) NSDate *lastUpdated;


- (id)init;

- (id)initWithProject:(PivotalProject *)theProject;

- (void)loadActivities;
- (void)loadedActivities:(id)theResult;
- (void)reloadActivities;
- (BOOL)hasCachedDocument;


@end
