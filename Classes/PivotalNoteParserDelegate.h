#import <Foundation/Foundation.h>
#import "PivotalResourceParserDelegate.h"

@class PivotalNote;
@interface PivotalNoteParserDelegate : PivotalResourceParserDelegate {
@private
    NSDateFormatter *dateFormatter;
    PivotalNote      *currentNote;
}

@end
