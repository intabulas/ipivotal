
#import <Foundation/Foundation.h>
#import "PivotalResourceParserDelegate.h"
#import "PivotalStory.h"

@class PivotalNote;
@interface PivotalStoriesParserDelegate : PivotalResourceParserDelegate {
@private
    NSDateFormatter *dateFormatter;
    PivotalStory     *currentStory;
    PivotalNote      *currentNote;
    BOOL handlingNotes;
    
}

@end
