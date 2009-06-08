#import <Foundation/Foundation.h>


@interface PivotalStory : NSObject {
    NSInteger storyId;
    NSString *storyType;
    NSURL    *url;
    NSInteger estimate;
    NSString *currentState;
    NSString *description;
    NSString *name;
    NSString *requestedBy;
    NSString *owner;
    NSDate  *createdAt;
    NSDate  *acceptedAt;
}

@property (nonatomic, readwrite) NSInteger storyId;
@property (nonatomic, retain) NSString *storyType;
@property (nonatomic, retain) NSURL    *url;
@property (nonatomic, readwrite) NSInteger estimate;
@property (nonatomic, retain) NSString *currentState;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *requestedBy;
@property (nonatomic, retain) NSString *owner;
@property (nonatomic, retain) NSDate  *createdAt;
@property (nonatomic, retain) NSDate  *acceptedAt;
@end

