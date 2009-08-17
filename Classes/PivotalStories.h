#import <Foundation/Foundation.h>
#import "PivotalProject.h"
#import "PivotalResource.h"

@interface PivotalStories : PivotalResource {
    PivotalProject *project;
@private
    NSURL *url;
    NSArray *stories;
    NSString *storyType;
}

@property (nonatomic,retain) NSURL *url;
@property (nonatomic,retain) NSArray *stories;
@property (nonatomic, retain) NSString *storyType;


- (id)initWithProject:(PivotalProject *)theProject andType:(NSString *)theType;;
- (void)loadStories;
- (void)loadedStories:(id)theResult;
- (void)reloadStories;


@end
