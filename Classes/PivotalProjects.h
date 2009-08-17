#import <Foundation/Foundation.h>
#import "PivotalResource.h"

@interface PivotalProjects : PivotalResource {
   @private
      NSURL *url;
      NSArray *projects;
}

@property (nonatomic,retain) NSURL *url;
@property (nonatomic,retain) NSArray *projects;

- (id)init;
- (void)loadProjects;
- (void)loadedProjects:(id)theResult;
- (void)reloadProjects;


@end
