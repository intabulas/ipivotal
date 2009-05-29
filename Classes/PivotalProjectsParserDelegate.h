
#import <Foundation/Foundation.h>
#import "PivotalResourceParserDelegate.h"
#import "PivotalProject.h"

@interface PivotalProjectsParserDelegate : PivotalResourceParserDelegate {
    @private
    NSDateFormatter *dateFormatter;
    PivotalProject *currentProject;    
}

@end
