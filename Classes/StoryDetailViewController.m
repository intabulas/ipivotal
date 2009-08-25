
#import "StoryDetailViewController.h"
#import "PivotalStory.h"
#import "PivotalProject.h"
#import "PivotalResource.h"
#import "ASIHTTPRequest.h"
#import "CommentsController.h"
#import "AddStoryViewController.h"

@implementation StoryDetailViewController
@synthesize story, project, storyTableView;


- (id)initWithStory:(PivotalStory *)theStory {
	[super initWithNibName:@"StoryDetailViewController" bundle:nil];
    
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
    [story release];
    [storyTableView release];
    [super dealloc];
}   

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [commentsLabel setText:[NSString stringWithFormat:kLabelStoryComments, [self.story.comments count]]];
    
    
}

- (IBAction)showActions:(id)sender {
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:kTitleStoryActions delegate:self cancelButtonTitle:kButtonLabelCancel destructiveButtonTitle:nil otherButtonTitles:nil];


    
    if ( [self.story.currentState hasPrefix:kStateUnScheduled] ||  [self.story.currentState hasPrefix:kStateUnStarted] ) {
       [actionSheet addButtonWithTitle:kButtonLabelEditStory];
       [actionSheet addButtonWithTitle:kButtonLabelStart];
    } else if ([self.story.currentState hasPrefix:kStateStarted]) {
       [actionSheet addButtonWithTitle:kButtonLabelEditStory];        
        [actionSheet addButtonWithTitle:kButtonLabelFinish];                
    } else if ([self.story.currentState hasPrefix:kStateFinished]) {
        [actionSheet addButtonWithTitle:kButtonLabelDeliver];                
    } else if ([self.story.currentState hasPrefix:kStateDelivered]) {             
        [actionSheet addButtonWithTitle:kButtonLabelAccept];                
        [actionSheet addButtonWithTitle:kButtonLabelReject];                        
    } else if ( [self.story.currentState hasPrefix:kStateRejected] ) {        
       [actionSheet addButtonWithTitle:kButtonLabelRestart];                
    }
    

	[actionSheet showInView:self.view.window];
	[actionSheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    NSString *actionLabel =  [actionSheet buttonTitleAtIndex:buttonIndex];
    

    if ([actionLabel hasPrefix:@"Edit Story"]) {
        NSLog(@"Edit Story");

        AddStoryViewController *controller = [[AddStoryViewController alloc] initWithProject:project andStory:story];
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
        
        
	} else if ([actionLabel hasPrefix:kButtonLabelStart]) {
        [self toggleStoryState: kStateStarted ];

	} else if ([actionLabel hasPrefix:kButtonLabelFinish]) {
        [self toggleStoryState: kStateFinished ];
        
	} else if ([actionLabel hasPrefix:kButtonLabelDeliver]) {
        [self toggleStoryState: kStateDelivered ];
        
	} else if ([actionLabel hasPrefix:kButtonLabelAccept]) {
        [self toggleStoryState: kStateAccepted];
        
	} else if ([actionLabel hasPrefix:kButtonLabelReject]) {
        [self toggleStoryState: kStateRejected];
        
	} else if ([actionLabel hasPrefix:kButtonLabelRestart]) {        
        [self toggleStoryState: kStateStarted];        
    } else {
        NSLog(@"Unknown Action '%@'", actionLabel);
    }
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(showActions:)];

    
    [storyState setText:self.story.currentState];
    [storyRequestor setText:self.story.requestedBy];
    [storyOwner setText:self.story.owner];
    storyDescription.text = self.story.description;
    [storyName setText:self.story.name];
    
    if ( self.story.estimate == 1 ) estimateIcon.image = [UIImage imageNamed:kIconEstimateOnePoint];
    if ( self.story.estimate == 2 ) estimateIcon.image = [UIImage imageNamed:kIconEstimateTwoPoints];    
    if ( self.story.estimate == 3 ) estimateIcon.image = [UIImage imageNamed:kIconEstimateThreePoints];          
    
    estimate.text = [NSString stringWithFormat:kLabelStoryEstimation, self.story.storyType, self.story.estimate];
    
    if ( [story.storyType hasPrefix:kMatchBug] ) {    
        typeIcon.image = [UIImage imageNamed:kIconTypeBug];        
    } else if ( [self.story.storyType hasPrefix:kMatchFeature] ) {
        typeIcon.image = [UIImage imageNamed:kIconTypeFeature];
    } else if ( [self.story.storyType hasPrefix:kMatchChore] ) {
        typeIcon.image = [UIImage imageNamed:kIconTypeChore];        
    } else if ( [self.story.storyType hasPrefix:kMatchRelease] ) {
        typeIcon.image = [UIImage imageNamed:kIconTypeRelease];
        
    }    
    
    
    [commentsLabel setText:[NSString stringWithFormat:kLabelStoryComments, [self.story.comments count]]];
    
    
    self.storyTableView.tableHeaderView = tableHeaderView;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return (section == 0) ? 4 : 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;    
    
    if ( section == 0 && row == 0 ) return stateCell;
    if ( section == 0 && row == 1 ) return requestorCell;    
    if ( section == 0 && row == 2 ) return ownerCell;        
    if ( section == 0 && row == 3 ) return descriptionCell;
    
    if ( section == 1 && row == 0 ) { 
//        if ( [self.story.comments count] == 0 ) {
//            [commentsCell setAccessoryType:UITableViewCellAccessoryNone];
//            [commentsCell setUserInteractionEnabled:NO];
//        } else {
//            [commentsCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
//            [commentsCell setUserInteractionEnabled:YES];                
//        }
        return commentsCell;        
    }
    
    static NSString *CellIdentifier = @"Cell";

    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return  (indexPath.section == 0 && indexPath.row == 3) ? 60.0f : 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ( ( indexPath.section == 1 )  && (indexPath.row == 0) ){ 
		CommentsController *controller = [[CommentsController alloc] initWithProject:self.project andStory:self.story];
		[self.navigationController pushViewController:controller animated:YES];
		[controller release];
        
    }
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return ( indexPath.section == 1 );
}

#pragma mark Actions

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
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kLabelAddStory message:@"Story has been placed in the Icebox. \n\nIt may take a minute or two for it to show up in the list (api lag)" delegate:self cancelButtonTitle:@"okay" otherButtonTitles: nil];
    [alert show];
    [alert release];        
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];            
}

@end

