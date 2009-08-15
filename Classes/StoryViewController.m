#import "StoryViewController.h"
#import "NSDate+Nibware.h"
#import "ASIHTTPRequest.h"
#import "PivotalResource.h"
#import "PivotalStory.h"

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
    


    [startButton   setEnabled:([self.story.currentState hasPrefix:kStateUnScheduled] ||  [self.story.currentState hasPrefix:kStateUnStarted] )];
    
    [finishButton  setEnabled:[self.story.currentState hasPrefix:kStateStarted]];    
    
    [deliverButton setEnabled:[self.story.currentState hasPrefix:kStateFinished]];    

    [acceptButton  setEnabled:[self.story.currentState hasPrefix:kStateDelivered]];        
    [rejectButton  setEnabled:[self.story.currentState hasPrefix:kStateDelivered]];        
    
                                  
    
    NSMutableArray     *items = [[toolbar.items mutableCopy] autorelease];
    
    if ( ![self.story.currentState hasPrefix:kStateDelivered] && ![self.story.currentState hasPrefix:kStateRejected]  ) {
        [items removeObject:acceptButton];
        [items removeObject:rejectButton];
        [items removeObject:restartButton]; 
    } else if ( [self.story.currentState hasPrefix:kStateRejected] ) {        
        [items removeObject:acceptButton];
        [items removeObject:rejectButton];
        [items removeObject:startButton];
        [items removeObject:finishButton];        
        [items removeObject:deliverButton];        
    } else {
        [items removeObject:restartButton];        
        [items removeObject:startButton];
        [items removeObject:finishButton];        
        [items removeObject:deliverButton];        
    }
    //    [items removeObject: myButton];
    toolbar.items = items;    
    
    
    if ( self.story.estimate == 1 ) estimateIcon.image = [UIImage imageNamed:kIconEstimateOnePoint];
    if ( self.story.estimate == 2 ) estimateIcon.image = [UIImage imageNamed:kIconEstimateTwoPoints];    
    if ( self.story.estimate == 3 ) estimateIcon.image = [UIImage imageNamed:kIconEstimateThreePoints];          

    name.text = self.story.name;
    estimate.text = [NSString stringWithFormat:@"a %@, estimated as %d point(s)", self.story.storyType, self.story.estimate];
 
    if ( [story.storyType hasPrefix:kMatchBug] ) {    
        typeIcon.image = [UIImage imageNamed:kIconTypeBug];        
    } else if ( [self.story.storyType hasPrefix:kMatchFeature] ) {
        typeIcon.image = [UIImage imageNamed:kIconTypeFeature];
    } else if ( [self.story.storyType hasPrefix:kMatchChore] ) {
        typeIcon.image = [UIImage imageNamed:kIconTypeChore];        
    } else if ( [self.story.storyType hasPrefix:kMatchRelease] ) {
        typeIcon.image = [UIImage imageNamed:kIconTypeRelease];
        
    }    
    
    if ([self.story.comments count] > 0 ) {
        commentsIcon.image = [UIImage imageNamed:kIconComments];
    }
    
    
    currentState.text = self.story.currentState;
    
    requestedBy.text = self.story.requestedBy;
    ownedBy.text = self.story.owner;    
    description.text = self.story.description;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
}


- (void)toggleStoryState:(NSString *)newState {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;    
    NSString *urlString = [NSString stringWithFormat:kUrlUpdateStory, self.project.projectId, self.story.storyId];                            
	NSURL *followingURL = [NSURL URLWithString:urlString];    
    ASIHTTPRequest *request = [PivotalResource authenticatedRequestForURL:followingURL];
    NSString *newstory;
    if ( [self.story.storyType hasPrefix:kMatchFeature] ) {    
        newstory = [NSString stringWithFormat:kXmlStoryStateTransitiion, newState, self.story.estimate];
    } else {    
        newstory = [NSString stringWithFormat:kXmlStoryStateTransitiionNoEstimate, newState];
    }

#ifdef LOG_NETWORK    
    NSLog(@"Toggle Story State XML: %@", newstory);
#endif    
    [request setRequestMethod:@"PUT"];
    [request addRequestHeader:kHttpContentType value:kHttpMimeTypeXml];
    [request setPostBody:[[NSMutableData alloc] initWithData:[newstory dataUsingEncoding:NSUTF8StringEncoding]]];
    [request start];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;    
    [pool release];    
}

- (IBAction)startStory:(id)sender {
    NSLog(@"toggling story state to: STARTED");
    [self toggleStoryState: kStateStarted ];
    [self.navigationController popViewControllerAnimated:YES];        
}


- (IBAction)finishStory:(id)sender {
    NSLog(@"toggling story state to: FINISHED");
    [self toggleStoryState: kStateFinished ];
    [self.navigationController popViewControllerAnimated:YES];        
}

- (IBAction)deliverStory:(id)sender {
    NSLog(@"toggling story state to: DELIVERED");    
    [self toggleStoryState: kStateDelivered ];
    [self.navigationController popViewControllerAnimated:YES];        
}

- (IBAction)acceptStory:(id)sender {
    NSLog(@"toggling story state to: ACCEPTED");    
    [self toggleStoryState: kStateAccepted];
    [self.navigationController popViewControllerAnimated:YES];        
}

- (IBAction)rejectStory:(id)sender {
    NSLog(@"toggling story state to: REJECTED");
    [self toggleStoryState: kStateRejected];
    [self.navigationController popViewControllerAnimated:YES];        
}


@end
