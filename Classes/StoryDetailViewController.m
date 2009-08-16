
#import "StoryDetailViewController.h"
#import "PivotalStory.h"
#import "PivotalProject.h"
#import "PivotalResource.h"
#import "ASIHTTPRequest.h"

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

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/




- (IBAction)showActions:(id)sender {
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Story Actions" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:nil];

    
//    [startButton   setEnabled:([self.story.currentState hasPrefix:kStateUnScheduled] ||  [self.story.currentState hasPrefix:kStateUnStarted] )];
//    
//    [finishButton  setEnabled:[self.story.currentState hasPrefix:kStateStarted]];    
//    
//    [deliverButton setEnabled:[self.story.currentState hasPrefix:kStateFinished]];    
//    
//    [acceptButton  setEnabled:[self.story.currentState hasPrefix:kStateDelivered]];        
//    [rejectButton  setEnabled:[self.story.currentState hasPrefix:kStateDelivered]];        
//    
    
    
    if ( [self.story.currentState hasPrefix:kStateUnScheduled] ||  [self.story.currentState hasPrefix:kStateUnStarted] ) {
        [actionSheet addButtonWithTitle:@"Start"];
    } else if ([self.story.currentState hasPrefix:kStateStarted]) {
        [actionSheet addButtonWithTitle:@"Finish"];                
    } else if ([self.story.currentState hasPrefix:kStateFinished]) {
        [actionSheet addButtonWithTitle:@"Deliver"];                
    } else if ([self.story.currentState hasPrefix:kStateDelivered]) {             
        [actionSheet addButtonWithTitle:@"Accept"];                
        [actionSheet addButtonWithTitle:@"Reject"];                        
    } else if ( [self.story.currentState hasPrefix:kStateRejected] ) {        
       [actionSheet addButtonWithTitle:@"Restart"];                
    }
    
    
    
	[actionSheet showInView:self.view.window];
	[actionSheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    NSString *actionLabel =  [actionSheet buttonTitleAtIndex:buttonIndex];
    

    
	if ([actionLabel hasPrefix:@"Start"]) {
        [self toggleStoryState: kStateStarted ];

	} else if ([actionLabel hasPrefix:@"Finish"]) {
        [self toggleStoryState: kStateFinished ];
        
	} else if ([actionLabel hasPrefix:@"Deliver"]) {
        [self toggleStoryState: kStateDelivered ];
        
	} else if ([actionLabel hasPrefix:@"Accept"]) {
        [self toggleStoryState: kStateAccepted];
        
	} else if ([actionLabel hasPrefix:@"Reject"]) {
        [self toggleStoryState: kStateRejected];
        
	} else if ([actionLabel hasPrefix:@"Restart"]) {        
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
//    [storyDescription setText:self.story.description];
    storyDescription.text = self.story.description;
    [storyName setText:self.story.name];
    
    if ( self.story.estimate == 1 ) estimateIcon.image = [UIImage imageNamed:kIconEstimateOnePoint];
    if ( self.story.estimate == 2 ) estimateIcon.image = [UIImage imageNamed:kIconEstimateTwoPoints];    
    if ( self.story.estimate == 3 ) estimateIcon.image = [UIImage imageNamed:kIconEstimateThreePoints];          
    
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
    
    
    [commentsLabel setText:[NSString stringWithFormat:@"%d Comments", [self.story.comments count]]];
    
    
    self.storyTableView.tableHeaderView = tableHeaderView;

    
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
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
    
    if ( section == 1 && row == 0 ) return commentsCell;        
    
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
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return ( indexPath.section == 1 );
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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

