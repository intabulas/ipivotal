#import <Foundation/Foundation.h>
#import "PivotalResourceParserDelegate.h"
#import "PivotalIteration.h"
#import "PivotalStory.h"

@interface PivotalIterationsParserDelegate : PivotalResourceParserDelegate {
@private
    BOOL handlingStory;
    NSDateFormatter *dateFormatter;
    PivotalIteration *currentIteration;\
    PivotalStory     *currentStory;
}

@end
