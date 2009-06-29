#import <Foundation/Foundation.h>
#import "PivotalActivities.h"
#import "PivotalActivity.h"
#import "PivotalResourceParserDelegate.h"

@interface PivotalActivityParserDelegate : PivotalResourceParserDelegate {
@private
    NSDateFormatter *dateFormatter;
    PivotalActivity     *currentActivity;
}

@end
