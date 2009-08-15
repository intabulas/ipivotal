#import <Foundation/Foundation.h>

@interface PivotalNote : NSObject {
    NSInteger noteId;
    NSString *text;
    NSString *author;
    NSDate   *createdAt;
}

@property (nonatomic, readwrite) NSInteger noteId;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSDate *createdAt;

- (id)init;

@end
