#import <Foundation/Foundation.h>
#import "PivotalResource.h"
#import "PivotalProject.h"


@interface PivotalIterations : PivotalResource {
    PivotalProject *project;
@private
    NSURL *url;
    NSString* group;
    NSArray *iterations;
}

@property (nonatomic,retain) PivotalProject *project;
@property (nonatomic,retain) NSURL *url;
@property (nonatomic,retain) NSArray *iterations;
@property (nonatomic, retain) NSString* group;


- (id)initWithProject:(PivotalProject *)theProject;
- (void)loadIterations;
- (void)loadedIterations:(id)theResult;
- (void)reloadIterations;
- (void)reloadInterationForGroup:(NSString*)theGroup;

@end
