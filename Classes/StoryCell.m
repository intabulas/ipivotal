
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
    
    
    
    if ( [story.currentState hasPrefix:@"accepted"] ) {
           theColor = [UIColor colorWithRed:216.0/255.0 green:238.0/255.0 blue:206.0/255.0 alpha:1.0];
    } else if ( [story.currentState hasPrefix:@"started"] || [story.currentState hasPrefix:@"delivered"] ) {
           theColor = [UIColor colorWithRed:255.0/255.0 green:248.0/255.0 blue:228.0/255.0 alpha:1.0];
    } else if ( [story.currentState hasPrefix:@"unstarted"] && [story.storyType hasPrefix:@"release"] ) {
       theColor = [UIColor colorWithRed:64.0/255.0 green:122.0/255.0 blue:165.0/255.0 alpha:1.0];        
    } else if ( [story.currentState hasPrefix:@"unscheduled"] ) {
        theColor = [UIColor colorWithRed:231.0/255.0 green:243.0/255.0 blue:250.0/255.0 alpha:1.0];        
        
    } else {
        theColor = [UIColor whiteColor];
    }

    estimateIcon.image = [UIImage imageNamed: kIconEstimateNone];
    if ( story.estimate == 1 ) estimateIcon.image = [UIImage imageNamed:kIconEstimateOnePoint];
    if ( story.estimate == 2 ) estimateIcon.image = [UIImage imageNamed:kIconEstimateTwoPoints];    
    if ( story.estimate == 3 ) estimateIcon.image = [UIImage imageNamed: kIconEstimateThreePoints];        
    
//       
//       theColor = [UIColor colorWithRed:216.0/255.0 green:238.0/255.0 blue:206.0/255.0 alpha:1.0];
    
    if ( [story.storyType hasPrefix:@"bug"] ) {    
        icon.image = [UIImage imageNamed:kIconTypeBug];
        
    } else if ( [story.storyType hasPrefix:@"feature"] ) {
       icon.image = [UIImage imageNamed:kIconTypeFeature];
    } else if ( [story.storyType hasPrefix:@"chor"] ) {
       icon.image = [UIImage imageNamed:kIconTypeChore];

    } else if ( [story.storyType hasPrefix:@"release"] ) {
       icon.image = [UIImage imageNamed:kIconTypeRelease];
    
    }
    
    
    state.text = story.currentState;

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
    [estimateIcon release];
    [super dealloc];
}


@end
