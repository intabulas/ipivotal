#import <Foundation/Foundation.h>


@interface PivotalProject : NSObject {
    NSInteger projectId;
    NSString *name;
    NSInteger iterationLength;
    NSString *weekStartDay;
    NSString *pointScale;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *weekStartDay;
@property (nonatomic, retain) NSString *pointScale;
@property (nonatomic, readwrite) NSInteger  projectId;
@property (nonatomic, readwrite) NSInteger iterationLength;
@end

