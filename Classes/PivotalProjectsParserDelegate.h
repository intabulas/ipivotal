
#import <Foundation/Foundation.h>
#import "PivotalResourceParserDelegate.h"
#import "PivotalProject.h"

@interface PivotalProjectsParserDelegate : PivotalResourceParserDelegate {
    @private
    PivotalProject *currentProject;    
}

@end
