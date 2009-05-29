#import <Foundation/Foundation.h>


@interface PivotalProjects : PivotalResource {
   @private
      NSURL *url;
      NSArray *projects;
      NSString *cacheFilename;
      NSDate *lastUpdated;    
}

@property (nonatomic,retain) NSURL *url;
@property (nonatomic,retain) NSArray *projects;
@property (nonatomic, retain) NSString *cacheFilename;
@property (nonatomic, retain) NSDate *lastUpdated;


- (id)init;
- (void)loadProjects;
- (void)loadedProjects:(id)theResult;
- (void)reloadProjects;
- (BOOL)hasCachedDocument;


@end
