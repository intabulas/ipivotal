
#import <Foundation/Foundation.h>
#import "PivotalResourceParserDelegate.h"
#import "PivotalStory.h"

@interface PivotalStoriesParserDelegate : PivotalResourceParserDelegate {
@private
    NSDateFormatter *dateFormatter;
    PivotalStory     *currentStory;
}

@end
