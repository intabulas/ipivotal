#import "StoryViewController.h"
#import "NSDate+Nibware.h"
#import "ASIHTTPRequest.h"
#import "PivotalResource.h"

@implementation StoryViewController

@synthesize story, project;

- (id)initWithStory:(PivotalStory *)theStory {
    [super init];
    self.story = theStory;
    return self;
}

- (id)initWithStory:(PivotalStory *)theStory andProject:(PivotalProject *)theProject {
    [self initWithStory:theStory];
    self.project = theProject;
    return self;
}

- (void)dealloc {
    [project release]; 
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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(startStory:)];

    [startButton setEnabled:[self.story.currentState hasPrefix:kStateUnScheduled]];
    
    
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


- (IBAction)startStory:(id)sender {
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSString *urlString = [NSString stringWithFormat:kUrlUpdateStory, self.project.projectId, self.story.storyId];                            
	NSURL *followingURL = [NSURL URLWithString:urlString];    
    ASIHTTPRequest *request = [PivotalResource authenticatedRequestForURL:followingURL];
    NSString *newstory = [NSString stringWithFormat:@"<story><current_state>started</current_state><estimate type=\"Integer\">%d</estimate></story>", self.story.estimate];
    [request setRequestMethod:@"PUT"];
    [request addRequestHeader:@"Content-type" value:@"application/xml"];
    [request setPostBody:[[NSMutableData alloc] initWithData:[newstory dataUsingEncoding:NSUTF8StringEncoding]]];
    [request start];
    [pool release];    
    
    [self.navigationController popViewControllerAnimated:YES];        
    
}

@end
