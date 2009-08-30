#import <Foundation/Foundation.h>
#import "PivotalResource.h"

@class PivotalProject, PivotalStory;
@interface PivotalTask : PivotalResource {
    PivotalProject *project;
    PivotalStory *story;    
@private
    NSInteger taskId;
    NSString *description;
    NSInteger position;
    BOOL complete;
    NSDate   *createdAt;
}

@property (nonatomic, readwrite) NSInteger taskId;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, readwrite) NSInteger position;
@property (nonatomic, readwrite) BOOL  complete;
@property (nonatomic, retain) NSDate *createdAt;

-(id)initWithProject:(PivotalProject *)theProject andStory:(PivotalStory *)theStory;

@end
