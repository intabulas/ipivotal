//
//	Copyright (c) 2008-2010, Mark Lussier
//	http://github.com/intabulas/ipivotal
//	All rights reserved.
//
//	This software is released under the terms of the BSD License.
//	http://www.opensource.org/licenses/bsd-license.php
//
//	Redistribution and use in source and binary forms, with or without modification,
//	are permitted provided that the following conditions are met:
//
//	* Redistributions of source code must retain the above copyright notice, this
//	  list of conditions and the following disclaimer.
//	* Redistributions in binary form must reproduce the above copyright notice,
//	  this list of conditions and the following disclaimer
//	  in the documentation and/or other materials provided with the distribution.
//	* Neither the name of iPivotal nor the names of its contributors may be used
//	  to endorse or promote products derived from this software without specific
//	  prior written permission.
//
//	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//	ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
//	IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
//	INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
//	BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
//	DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
//	LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
//	OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
//	OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "StoryDetailViewController.h"
#import "PivotalStory.h"
#import "PivotalProject.h"
#import "PivotalResource.h"
#import "ASIHTTPRequest.h"
#import "CommentsController.h"
#import "AddStoryViewController.h"
#import "NSDate+Nibware.h"
#import "PivotalStoriesParserDelegate.h"
#import "TaskViewController.h"


@interface StoryDetailViewController ()
- (void)displayStory;
@end

@implementation StoryDetailViewController
@synthesize story, project, stories, storyTableView, actionToolbar;

- (id)initWithStories:(NSArray *)theStories andIndex:(NSUInteger)theIndex {
	[super initWithNibName:@"StoryDetailViewController" bundle:nil];
    self.stories = theStories;
    currentIndex = theIndex;
    self.story = [stories objectAtIndex:currentIndex];
    return self;
    
}

- (id)initWithStories:(NSArray *)theStories andIndex:(NSUInteger)theIndex andProject:(PivotalProject *)theProject {
    [self initWithStories:theStories andIndex:theIndex];
    self.project = theProject;
    return self;
    
}

- (id)initWithStory:(PivotalStory *)theStory {
	[super initWithNibName:@"StoryDetailViewController" bundle:nil];
    
    self.story = theStory;
    return self;
}

//- (id)initWithStory:(PivotalStory *)theStory andProject:(PivotalProject *)theProject {
//    [self initWithStory:theStory];
//    self.project = theProject;
//    return self;
//}

- (void)dealloc {
    [project release];  project = nil;
    [story release]; story = nil;
    [actionToolbar release]; actionToolbar = nil;
    [storyTableView release]; storyTableView = nil;
    [super dealloc];
}   

- (void) updateActions {
    NSMutableArray *buttonItems = [[NSMutableArray alloc] init];
    
     [buttonItems addObject:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease]];
    
    if ( [self.story.currentState hasPrefix:kStateUnScheduled] ||  [self.story.currentState hasPrefix:kStateUnStarted] ) {
        [buttonItems addObject:[[[UIBarButtonItem alloc] initWithTitle:kButtonLabelEditStory style:UIBarButtonItemStyleBordered target:self action:@selector(editStory:)] autorelease]];
        [buttonItems addObject:[[[UIBarButtonItem alloc] initWithTitle:kButtonLabelStart     style:UIBarButtonItemStyleBordered target:self action:@selector(startStory:)] autorelease]];        
    } else  if ([self.story.currentState hasPrefix:kStateStarted]) {        
        [buttonItems addObject:[[[UIBarButtonItem alloc] initWithTitle:kButtonLabelEditStory style:UIBarButtonItemStyleBordered target:self action:@selector(editStory:)] autorelease]];
        [buttonItems addObject:[[[UIBarButtonItem alloc] initWithTitle:kButtonLabelFinish    style:UIBarButtonItemStyleBordered target:self action:@selector(finishStory:)] autorelease]];
    } else if ([self.story.currentState hasPrefix:kStateFinished]) {
        [buttonItems addObject:[[[UIBarButtonItem alloc] initWithTitle:kButtonLabelDeliver   style:UIBarButtonItemStyleBordered target:self action:@selector(deliverStory:)] autorelease]];
        
    } else if ([self.story.currentState hasPrefix:kStateDelivered]) {   
        [buttonItems addObject:[[[UIBarButtonItem alloc] initWithTitle:kButtonLabelAccept    style:UIBarButtonItemStyleBordered target:self action:@selector(acceptStory:)] autorelease]];
        [buttonItems addObject:[[[UIBarButtonItem alloc] initWithTitle:kButtonLabelReject    style:UIBarButtonItemStyleBordered target:self action:@selector(rejectStory:)] autorelease]];
    } else if ( [self.story.currentState hasPrefix:kStateRejected] ) {        
        [buttonItems addObject:[[[UIBarButtonItem alloc] initWithTitle:kButtonLabelRestart   style:UIBarButtonItemStyleBordered target:self action:@selector(restartStory:)] autorelease]];
        
    }
     [buttonItems addObject:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease]];

    if ( buttonItems.count > 0 ) { [self.actionToolbar setItems:buttonItems]; }
    
    [buttonItems release];    
}
- (void)viewWillAppear:(BOOL)animated { 
    [self.navigationItem setTitle:kLabelStoryDetails]; 
    //[self updateActions];
    [self displayStory];    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [commentsLabel setText:[NSString stringWithFormat:kLabelStoryComments, [self.story.comments count]]];
	[attachmentsLabel setText:[NSString stringWithFormat:kLabelStoryAttachments, [self.story.attachments count]]];
    [tasksLabel setText:[NSString stringWithFormat:kLabelStoryTasks, [self.story.tasks count]]];
    
}



#pragma mark === Toolbar Actions ===

- (void)editStory:(id)sender {
    AddStoryViewController *controller = [[AddStoryViewController alloc] initWithProject:self.project andStory:self.story];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];    
}

- (void)startStory:(id)sender {
    [self toggleStoryState: kStateStarted ];
}

- (void)finishStory:(id)sender {
    [self toggleStoryState: kStateFinished ];
}


- (void)deliverStory:(id)sender {
      [self toggleStoryState: kStateDelivered ];
}


- (void)acceptStory:(id)sender {
    [self toggleStoryState: kStateAccepted];
}

- (void)rejectStory:(id)sender {
    [self toggleStoryState: kStateRejected];
}

- (void)restartStory:(id)sender {
    [self toggleStoryState: kStateStarted];
}


#pragma mark  ==
- (IBAction)segmentChanged:(UISegmentedControl *)segmentedControl {
	currentIndex += (segmentedControl.selectedSegmentIndex == 0) ? -1 : 1;
	self.story = [stories objectAtIndex:currentIndex];
	[self displayStory];
}
#pragma mark ===

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(showActions:)];
    self.navigationItem.rightBarButtonItem = controlItem;
    self.storyTableView.tableHeaderView = tableHeaderView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ( section == 0) {
        return 4;
    } else if (section == 1 ) {
        return 3;
    } else {
        return 2;
    }
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
	if ( section == 1 && row == 1 ) return tasksCell;	
    if ( section == 1 && row == 2 ) return attachmentsCell;	

    if ( section == 2 && row == 0 ) return createdAtCell;	
    if ( section == 2 && row == 1 ) return updatedAtCell;	    
    
//    if ( section == 1 && row == 0 ) { 
////        if ( [self.story.comments count] == 0 ) {
////            [commentsCell setAccessoryType:UITableViewCellAccessoryNone];
////            [commentsCell setUserInteractionEnabled:NO];
////        } else {
////            [commentsCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
////            [commentsCell setUserInteractionEnabled:YES];                
////        }
//        return commentsCell;        
//    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifierCell];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kIdentifierCell] autorelease];
    }
    
    // Set up the cell...
	
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return  (indexPath.section == 0 && indexPath.row == 3) ? 60.0f : 40.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ( ( indexPath.section == 1 )  && (indexPath.row == 0) ){ 
		CommentsController *controller = [[CommentsController alloc] initWithProject:self.project andStory:self.story];
		[self.navigationController pushViewController:controller animated:YES];
		[controller release];
        
    }
    
    if ( ( indexPath.section == 1 )  && (indexPath.row == 2) ){ 
		TaskViewController *controller = [[TaskViewController alloc] initWithProject:self.project andStory:self.story];
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
    [self showHUD];
    
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
    
#if LOG_NETWORK    
    NSLog(@"Toggle Story State XML: %@", newstory);
#endif    
    [request setRequestMethod:@"PUT"];
    [request addRequestHeader:kHttpContentType value:kHttpMimeTypeXml];
    [request setPostBody:[[[NSMutableData alloc] initWithData:[newstory dataUsingEncoding:NSUTF8StringEncoding]] autorelease]];
    [request startSynchronous];
#if LOG_NETWORK    
    NSLog(@" Response: '%@'", [request responseString]);
#endif
    NSError *error = [request error];
    if ( !error ) {    
  	  PivotalStoriesParserDelegate *parserDelegate = [[PivotalStoriesParserDelegate alloc] initWithTarget:self andSelector:@selector(storyChanged:)]; 
	  NSXMLParser *parser = [[NSXMLParser alloc] initWithData:[request responseData]];
	  [parser setDelegate:parserDelegate];
	  [parser setShouldProcessNamespaces:NO];
	  [parser setShouldReportNamespacePrefixes:NO];
	  [parser setShouldResolveExternalEntities:NO];
	  [parser parse];
	  [parser release];
	  [parserDelegate release];    
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;    
    [self updateActions];
    [self hideHUD];
    [pool release];    
}

- (void)storyChanged:(id)theResult {
    if ( [theResult isKindOfClass:[NSError class]]) {
    } else {
        self.story = [theResult objectAtIndex:0];
        [self displayStory];
    }
}


#pragma mark == Display Story Detail ==
- (void)displayStory {
    
    [storyState setText:self.story.currentState];
    [storyRequestor setText:self.story.requestedBy];
    [storyOwner setText:self.story.owner];
    storyDescription.text = self.story.description;
    [storyName setText:self.story.name];
    
    if ( self.story.estimate == 1 ) estimateIcon.image = [UIImage imageNamed:kIconEstimateOnePoint];
    if ( self.story.estimate == 2 ) estimateIcon.image = [UIImage imageNamed:kIconEstimateTwoPoints];    
    if ( self.story.estimate == 3 ) estimateIcon.image = [UIImage imageNamed:kIconEstimateThreePoints];          
    
    if ( [self.story.storyType hasPrefix:kTypeFeature] || [self.story.storyType hasPrefix:kMatchFeature]) {
       estimate.text = [NSString stringWithFormat:kLabelStoryEstimation, [self.story.storyType capitalizedString], self.story.estimate];
    } else {
       estimate.text = [NSString stringWithFormat:kLabelStoryEstimationNonFeature, [self.story.storyType capitalizedString]];        
    }
    
    self.story.storyType = [self.story.storyType  lowercaseString];
    
    if ( [self.story.storyType hasPrefix:kMatchBug] ) {    
        typeIcon.image = [UIImage imageNamed:kIconTypeBug];        
    } else if ( [self.story.storyType hasPrefix:kMatchFeature] ) {
        typeIcon.image = [UIImage imageNamed:kIconTypeFeature];
    } else if ( [self.story.storyType hasPrefix:kMatchChore] ) {
        typeIcon.image = [UIImage imageNamed:kIconTypeChore];        
    } else if ( [self.story.storyType hasPrefix:kMatchRelease] ) {
        typeIcon.image = [UIImage imageNamed:kIconTypeRelease];
        
    }    
    
    
    [commentsLabel setText:[NSString stringWithFormat:kLabelStoryComments, [self.story.comments count]]];
    [attachmentsLabel setText:[NSString stringWithFormat:kLabelStoryAttachments, [self.story.attachments count]]];
    [tasksLabel setText:[NSString stringWithFormat:kLabelStoryTasks, [self.story.tasks count]]];
    
    
    if ( [self.story.attachments count] < 1 ) {
        [attachmentsCell  setSelectionStyle:UITableViewCellSelectionStyleNone];
        [attachmentsCell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    [createdAtLabel setText:[self.story.createdAt prettyDate]];
    [updatedAtLabel setText:[self.story.updatedAt prettyDate]]; 
    
	[navigationControl setEnabled:(currentIndex > 0) forSegmentAtIndex:0];
	[navigationControl setEnabled:(currentIndex < [stories count]-1) forSegmentAtIndex:1];
    
    [self updateActions];
    
}

#pragma mark ===

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}


@end

