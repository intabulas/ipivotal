#import "ProjectCell.h"
#import "PivotalProject.h"

@implementation ProjectCell

@synthesize project;

- (void)setProject:(PivotalProject *)aProject {
	[project release];
	project = [aProject retain];
	projectName.text = project.name;
    
    projectIcon.image = [UIImage imageNamed:@"lightbulb.png"];
}


- (void)dealloc {
    [project release];    
    [projectName release];    
    [projectIcon release]; 
    [super dealloc];
}


@end
