
#import "StoryCell.h"
#import "PivotalIteration.h"
#import "NSDate+Nibware.h"

@implementation StoryCell

@synthesize story;

- (void)setStory:(PivotalStory *)aStory {
	[story release];
	story = [aStory retain];
	name.text = story.name;
    UIColor *theColor;
    if ( [story.storyType hasPrefix:@"bug"] ) {    
        icon.image = [UIImage imageNamed:@"bug.png"];
        
    } else if ( [story.storyType hasPrefix:@"feature"] ) {
       icon.image = [UIImage imageNamed:@"feature.png"];
       theColor = [UIColor colorWithRed:216.0/255.0 green:238.0/255.0 blue:206.0/255.0 alpha:1.0];
    } else if ( [story.storyType hasPrefix:@"chor"] ) {
       icon.image = [UIImage imageNamed:@"chore.png"];
       theColor = [UIColor colorWithRed:216.0/255.0 green:238.0/255.0 blue:206.0/255.0 alpha:1.0];
    } else if ( [story.storyType hasPrefix:@"release"] ) {
       icon.image = [UIImage imageNamed:@"release.png"];
       theColor = [UIColor colorWithRed:64.0/255.0 green:122.0/255.0 blue:165.0/255.0 alpha:1.0];
    }
    

    UIView* backgroundView = [ [ [ UIView alloc ] initWithFrame:CGRectZero ] autorelease ];
    backgroundView.backgroundColor = theColor ;
    self.backgroundView = backgroundView;
    for ( UIView* view in self.contentView.subviews ) 
    {
        self.backgroundColor = [ UIColor clearColor ];
    }    
    
    
}


- (void)dealloc {
    [story release];    
    [name release];    
    [icon release];
    [super dealloc];
}


@end
