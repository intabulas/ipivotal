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

#import "IterationsViewController.h"
#import "PivotalIteration.h"
#import "PivotalStory.h"
#import "IterationCell.h"
#import "StoriesViewController.h"
#import "StoryDetailViewController.h"
#import "AddStoryViewController.h"
#import "IterationHeaderView.h"
#import "IterationStoryCell.h"
#import "ActivityLabelCell.h"
#import "CenteredLabelCell.h"
#import "ActivityViewController.h"
#import "NSDate+Nibware.h"
#import "PlaceholderCell.h"


@implementation IterationsViewController

@synthesize iterationTableView, project;

- (id)initWithProject:(PivotalProject *)theProject {
    [super init];
    lastIterationType = 1;
    self.project = theProject;
    return self;
}

- (void)dealloc {
    [iterations  removeObserver:self forKeyPath:kResourceStatusKeyPath];
    [project release]; project = nil;
    [iterations release]; iterations = nil;
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
	
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    
    iterations = [[PivotalIterations alloc] initWithProject:self.project];
    [iterations addObserver:self forKeyPath:kResourceStatusKeyPath options:NSKeyValueObservingOptionNew context:nil];
    if ( !iterations.isLoaded) { 
        [self showHUD];
        [iterations loadIterations];
    }
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = kLabelIterations;
    
    UISegmentedControl *segmentedControl = [[[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:kTypeDone, kTypeCurrent, kTypeBacklog, nil]] autorelease];
    [segmentedControl addTarget:self action:@selector(iterationTypeChanged:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentedControl.selectedSegmentIndex = lastIterationType;
    self.navigationItem.titleView = segmentedControl;
    
    
}

- (void)iterationTypeChanged:(id)sender {
    if ( iterations.isLoaded ) {
    NSInteger selectedIndex = ((UISegmentedControl*)sender).selectedSegmentIndex;
        lastIterationType = selectedIndex;
        [self showHUD];
    if ( selectedIndex == 0 ) {
        [iterations reloadInterationForGroup:kTypeDone];
    } else if ( selectedIndex == 1 ) {
        [iterations reloadInterationForGroup:kTypeCurrent];
    } else {
        [iterations reloadInterationForGroup:kTypeBacklog];        
    }
    }
}

- (void)loadIterations {
    if ( !iterations.isLoaded ) {
        [self showHUD];
        [iterations loadIterations];    
    }
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:kResourceStatusKeyPath]) {
        PivotalIterations *theIterations = (PivotalIterations *)object;
        if ( theIterations.isLoading) {
        } else {     
            [self hideHUD];
     		[self.iterationTableView reloadData];
        }        
	}    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; 
}



#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return ( (!iterations.isLoaded) || (iterations.iterations.count == 0))  ? 1 : [iterations.iterations count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    if ( !iterations.isLoaded) return 1;
    if ( iterations.iterations.count == 0 ) return 1;
    PivotalIteration *iteration = [iterations.iterations objectAtIndex:section];
    return (iteration.stories.count == 0 ) ? 1 : iteration.stories.count;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
        return nil;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    if ( !iterations.isLoaded && !self.isHudDisplayed) { [self showHUD]; } 

    
    if ( iterations.isLoaded && iterations.iterations.count == 0 ) {
        CenteredLabelCell *cell = (CenteredLabelCell*)[tableView dequeueReusableCellWithIdentifier:kIdentifierCenteredCell];
        if (cell == nil) {
            cell = [[[CenteredLabelCell alloc] initWithFrame:CGRectZero reuseIdentifier:kIdentifierCenteredCell] autorelease];
        }
        [cell.cellLabel setText:kLabelNoIterations];

        return  cell;        
    } 

    if ( !iterations.isLoaded) { 
        PlaceholderCell *cell = (PlaceholderCell*)[tableView dequeueReusableCellWithIdentifier:kIdentifierPlaceholderCell];
        if (cell == nil) {
            cell = [[[PlaceholderCell alloc] initWithFrame:CGRectZero reuseIdentifier:kIdentifierPlaceholderCell] autorelease];
        }
        return  cell;
        
    }    
    
    PivotalIteration *iteration = [iterations.iterations objectAtIndex:section];
    
    if ( iteration.stories.count == 0 ) { 
        CenteredLabelCell *cell = (CenteredLabelCell*)[tableView dequeueReusableCellWithIdentifier:kIdentifierCenteredCell];
        if (cell == nil) {
            cell = [[[CenteredLabelCell alloc] initWithFrame:CGRectZero reuseIdentifier:kIdentifierCenteredCell] autorelease];
        }
        [cell.cellLabel setText:kLabelNoStories];    
        return  cell;
    }    
    
    
    static NSString *CellIdentifier = kIdentifierIterationStoryCell;
    
    IterationStoryCell *cell = (IterationStoryCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
       cell = [[[IterationStoryCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    [cell setStory:[iteration.stories objectAtIndex:row]];
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;  
    
}


- (UIView *)tableView: (UITableView *)tableView viewForHeaderInSection: (NSInteger)section {

   if ( iterations.isLoaded && iterations.iterations.count != 0 ) {    
    IterationHeaderView* headerView = [[[IterationHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.iterationTableView.bounds.size.width, 40)] autorelease];   
       [headerView setIteration:[iterations.iterations objectAtIndex:section]];
	return headerView; 
   } else {
     return nil;
   }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   return 50.0f;    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ( iterations.isLoaded && iterations.iterations.count > 0 ) {
        PivotalIteration *iteration = [iterations.iterations objectAtIndex:indexPath.section];
        StoryDetailViewController *controller = [[StoryDetailViewController alloc] initWithStories:iteration.stories andIndex:indexPath.row andProject:project];
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    }
}


#pragma mark Actions

- (IBAction)refresh:(id)sender {
    [self showHUD];
    [iterations reloadIterations];
    [self.iterationTableView reloadData];  
}

-(IBAction)showIceboxStories:(id)sender {
    StoriesViewController *controller = [[StoriesViewController alloc] initWithProject:self.project andType:kTypeIcebox];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
}

-(IBAction)projectActivity:(id)sender {
    ActivityViewController *controller = [[ActivityViewController alloc] initWithProject:self.project];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];	    
	
}

-(IBAction)addStory:(id)sender {
    AddStoryViewController *controller = [[AddStoryViewController alloc] initWithProject:self.project];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];        
}

- (void)deleteStory:(PivotalStory *)deleteStory {
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [self showHUDWithLabel:kLabelDeletingStory];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;    
    NSString *urlString = [NSString stringWithFormat:kUrlDeleteStory, project.projectId, deleteStory.storyId];                            
	NSURL *followingURL = [NSURL URLWithString:urlString];    
    ASIHTTPRequest *request = [PivotalResource authenticatedRequestForURL:followingURL];
    [request setRequestMethod:@"DELETE"];
    [request startSynchronous];
#if LOG_NETWORK    
    NSLog(@" Response: '%@'", [request responseString]);
#endif
    NSError *error = [request error];
    [self hideHUD];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;    

    if ( error ) {
        UIAlertView *alert;        
        alert = [[UIAlertView alloc] initWithTitle:@"Error Deleting Story" message:@"There was a problem deleting this story. Please try again later" delegate:self cancelButtonTitle:@"okay" otherButtonTitles: nil];
        [alert show];
        [alert release];            
    }
    
    [pool release];        
    [self refresh:self];    
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PivotalIteration *iteration = [iterations.iterations objectAtIndex:indexPath.section];
        PivotalStory *story = [iteration.stories objectAtIndex:indexPath.row];
        [self deleteStory:story];
        
    } 
}

- (IBAction)edit:(id)sender {
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(cancel:)] autorelease];    
    [self.iterationTableView setEditing:TRUE animated:YES];
}

- (void)cancel:(id)sender {
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit:)] autorelease];    
    [self.iterationTableView setEditing:FALSE animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}

@end

