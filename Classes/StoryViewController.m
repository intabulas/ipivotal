#import "StoryViewController.h"
#import "NSDate+Nibware.h"

@implementation StoryViewController

@synthesize story;

- (id)initWithStory:(PivotalStory *)theStory {
    [super init];
    self.story = theStory;
    return self;
}

- (void)dealloc {
    [description release];
    [story release];
    [name release];
    [estimate release];
    [typeIcon release];
    [currentState release];
    [estimateIcon release];    
    [requestedBy release];
    [ownedBy release];
    [super dealloc];
}    

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Story";
    
    if ( self.story.estimate == 1 ) estimateIcon.image = [UIImage imageNamed:@"estimate_1pt.gif"];
    if ( self.story.estimate == 2 ) estimateIcon.image = [UIImage imageNamed:@"estimate_2pt.gif"];    
    if ( self.story.estimate == 3 ) estimateIcon.image = [UIImage imageNamed:@"estimate_3pt.gif"];          

    name.text = self.story.name;
    estimate.text = [NSString stringWithFormat:@"Estimated as %d points", self.story.estimate];
 
    if ( [story.storyType hasPrefix:@"bug"] ) {    
        typeIcon.image = [UIImage imageNamed:kIconTypeBug];        
    } else if ( [self.story.storyType hasPrefix:@"feature"] ) {
        typeIcon.image = [UIImage imageNamed:kIconTypeFeature];
    } else if ( [self.story.storyType hasPrefix:@"chor"] ) {
        typeIcon.image = [UIImage imageNamed:kIconTypeChore];        
    } else if ( [self.story.storyType hasPrefix:@"release"] ) {
        typeIcon.image = [UIImage imageNamed:kIconTypeRelease];
        
    }    
    
    currentState.text = self.story.currentState;
    
    requestedBy.text = self.story.requestedBy;
    ownedBy.text = self.story.owner;    
    description.text = self.story.description;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
}


@end
