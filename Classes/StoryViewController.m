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
    
    if ( self.story.estimate == 1 ) estimateIcon.image = [UIImage imageNamed:kIconEstimateOnePoint];
    if ( self.story.estimate == 2 ) estimateIcon.image = [UIImage imageNamed:kIconEstimateTwoPoints];    
    if ( self.story.estimate == 3 ) estimateIcon.image = [UIImage imageNamed:kIconEstimateThreePoints];          

    name.text = self.story.name;
    estimate.text = [NSString stringWithFormat:@"Estimated as %d points", self.story.estimate];
 
    if ( [story.storyType hasPrefix:kMatchBug] ) {    
        typeIcon.image = [UIImage imageNamed:kIconTypeBug];        
    } else if ( [self.story.storyType hasPrefix:kMatchFeature] ) {
        typeIcon.image = [UIImage imageNamed:kIconTypeFeature];
    } else if ( [self.story.storyType hasPrefix:kMatchChore] ) {
        typeIcon.image = [UIImage imageNamed:kIconTypeChore];        
    } else if ( [self.story.storyType hasPrefix:kMatchRelease] ) {
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
