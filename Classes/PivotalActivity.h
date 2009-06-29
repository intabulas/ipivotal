

#import <Foundation/Foundation.h>


@interface PivotalActivity : NSObject {
	NSInteger activityId;
	NSString *project;
	NSString *story;
	NSString *description;
	NSString *author;
	NSDate   *when;
 
}

@property (nonatomic,readwrite) NSInteger activityId;
@property (nonatomic,retain) NSString *project;
@property (nonatomic,retain) NSString *story;
@property (nonatomic,retain) NSString *description;
@property (nonatomic,retain) NSString *author;
@property (nonatomic,retain) NSDate   *when;

@end
