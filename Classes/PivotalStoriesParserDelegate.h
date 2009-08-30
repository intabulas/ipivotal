
#import <Foundation/Foundation.h>
#import "PivotalResourceParserDelegate.h"
#import "PivotalStory.h"

@class PivotalNote, PivotalTask;
@interface PivotalStoriesParserDelegate : PivotalResourceParserDelegate {
@private
    NSDateFormatter *dateFormatter;
    PivotalStory     *currentStory;
    PivotalNote      *currentNote;
    PivotalTask      *currentTask;
    BOOL handlingNotes;
    BOOL handlingTasks;
    
}

@end
