#import <Foundation/Foundation.h>
#import "PivotalResource.h"

@class PivotalProject;

@interface PivotalActivities : PivotalResource {
	NSArray *activities;
    NSURL *url;	
}

@property (nonatomic,retain) NSURL *url;
@property (nonatomic,retain) NSArray *activities;


- (id)init;

- (id)initWithProject:(PivotalProject *)theProject;

- (void)loadActivities;
- (void)loadedActivities:(id)theResult;
- (void)reloadActivities;


@end
