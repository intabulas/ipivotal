#import <Foundation/Foundation.h>
#import "PivotalResourceParserDelegate.h"

@class PivotalNote, PivotalStory, PivotalIteration;
@interface PivotalIterationsParserDelegate : PivotalResourceParserDelegate {
@private
    BOOL handlingStory;
    BOOL handlingNotes;    
    NSDateFormatter *dateFormatter;
    PivotalIteration *currentIteration;
    PivotalNote      *currentNote;
    PivotalStory     *currentStory;
}

@end
