#import <Foundation/Foundation.h>


@interface PivotalIteration : NSObject {
    NSInteger iterationId;
    NSInteger iterationNumber;
    NSDate    *startDate;
    NSDate    *endDate;    
    NSMutableArray *stories;

}

@property (nonatomic, readwrite) NSInteger iterationId;
@property (nonatomic, readwrite) NSInteger iterationNumber;
@property (nonatomic, retain) NSDate    *startDate;
@property (nonatomic, retain) NSDate    *endDate ;   
@property (nonatomic, retain) NSMutableArray *stories;
@end
