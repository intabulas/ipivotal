#import "StoryViewController.h"
#import "NSDate+Nibware.h"

@implementation StoryViewController


- (id)initWithStory:(PivotalStory *)theStory {
    [super init];
    story = theStory;
    return self;
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Story";
    
    if ( story.estimate == 1 ) estimateIcon.image = [UIImage imageNamed:@"estimate_1pt.gif"];
    if ( story.estimate == 2 ) estimateIcon.image = [UIImage imageNamed:@"estimate_2pt.gif"];    
    if ( story.estimate == 3 ) estimateIcon.image = [UIImage imageNamed:@"estimate_3pt.gif"];          

    name.text = story.name;
    estimate.text = [NSString stringWithFormat:@"Estimated as %d points", story.estimate];
 
    if ( [story.storyType hasPrefix:@"bug"] ) {    
        typeIcon.image = [UIImage imageNamed:@"bug.png"];        
    } else if ( [story.storyType hasPrefix:@"feature"] ) {
        typeIcon.image = [UIImage imageNamed:@"feature.png"];
    } else if ( [story.storyType hasPrefix:@"chor"] ) {
        typeIcon.image = [UIImage imageNamed:@"chore.png"];        
    } else if ( [story.storyType hasPrefix:@"release"] ) {
        typeIcon.image = [UIImage imageNamed:@"release.png"];
        
    }    
    
    currentState.text = story.currentState;
    if ( story.acceptedAt ) acceptedDate.text = [story.acceptedAt prettyDate];
    
    requestedBy.text = story.requestedBy;
    ownedBy.text = story.owner;    
    description.text = story.description;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [description release];
    [story release];
    [name release];
    [estimate release];
    [typeIcon release];
    [currentState release];
    [acceptedDate release];
    [estimateIcon release];    
    [requestedBy release];
    [ownedBy release];
    [super dealloc];
}


@end
