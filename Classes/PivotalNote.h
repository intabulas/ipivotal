#import <Foundation/Foundation.h>
#import "PivotalResource.h"

@class PivotalProject, PivotalStory;
@interface PivotalNote : PivotalResource {
    PivotalProject *project;
    PivotalStory *story;    
    @private
    NSInteger noteId;
    NSString *text;
    NSString *author;
    NSDate   *createdAt;
    CGFloat visualHeight;
}

@property (nonatomic, readwrite) NSInteger noteId;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSDate *createdAt;
@property (nonatomic, readwrite) CGFloat visualHeight;

-(id)initWithProject:(PivotalProject *)theProject andStory:(PivotalStory *)theStory;
- (void)saveNote;
- (NSString *)to_xml;


@end
