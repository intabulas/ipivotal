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

#import "StoriesViewController.h"
#import "StoryDetailViewController.h"
#import "AddStoryViewController.h"
#import "IterationStoryCell.h"
#import "CenteredLabelCell.h"
#import "ActivityLabelCell.h"
#import "NSDate+Nibware.h"
#import "PlaceholderCell.h"


@implementation StoriesViewController

@synthesize toolbar, storiesTableView;

- (id)initWithProject:(PivotalProject *)theProject andType:(NSString *)theType {
    [super init];
    project = [theProject retain];
    storyType = theType;

    return self;
}

- (void)dealloc {
    [stories  removeObserver:self forKeyPath:kResourceStatusKeyPath];
    [storyType release]; storyType = nil;
    [stories release]; stories = nil;
    [toolbar release]; toolbar = nil;
    [storiesTableView release]; storiesTableView = nil;
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit:)];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
    
//    CGRect viewFrame = self.view.bounds;
//    viewFrame.size.height = viewFrame.size.height - 89;
//	storiesTableView = [[EGOTableViewPullRefresh alloc] initWithFrame:viewFrame style:UITableViewStylePlain];
//	storiesTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//	storiesTableView.dataSource = self;
//	storiesTableView.delegate = storiesTableView;
//	[self.view addSubview:storiesTableView];  
//
//    
	//create toolbar using new
//    toolbar = [UIToolbar new];
//    toolbar.barStyle = UIBarStyleDefault;
//    [toolbar sizeToFit];
//    toolbar.frame = CGRectMake(160, 438, 320, 44);    
//
//     
//    UIBarButtonItem *addStoryButton = [[UIBarButtonItem alloc] initWithTitle:@"Add Story" style:UIBarButtonItemStyleBordered target:nil action:@selector(addStory:)];
//    NSArray *items = [NSArray arrayWithObject:addStoryButton];
//    [addStoryButton release];
//    [toolbar setItems: items animated:NO];

    
//    [self.view addSubview:toolbar];
    
    
    
    stories = [[PivotalStories alloc] initWithProject:project andType:storyType];
    [stories addObserver:self forKeyPath:kResourceStatusKeyPath options:NSKeyValueObservingOptionNew context:nil];
    if ( !stories.isLoaded) { 
        [self showHUD];
        [stories loadStories];
    }
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = [storyType capitalizedString];
    [self refresh:self];
}


- (void)loadStories {
    if ( !stories.isLoaded ) {
       [self showHUD];
        [stories loadStories];    
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:kResourceStatusKeyPath]) {
        PivotalStories *theStories = (PivotalStories *)object;
        if ( theStories.isLoading) {
        } else {         
            [self hideHUD]; 
     		[self.storiesTableView reloadData];
        }        
	}    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ( !stories.isLoaded || stories.stories.count == 0 ) ? 1 : [stories.stories count];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSInteger row = indexPath.row;
    
    if ( stories.isLoading) { 
        PlaceholderCell *cell = (PlaceholderCell*)[tableView dequeueReusableCellWithIdentifier:kIdentifierPlaceholderCell];
        if (cell == nil) {
            cell = [[[PlaceholderCell alloc] initWithFrame:CGRectZero reuseIdentifier:kIdentifierPlaceholderCell] autorelease];
        }
        return  cell;        
    }    
    
    if ( stories.stories.count == 0 ) { 
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
    [cell setStory:[stories.stories objectAtIndex:row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
	return cell;    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ( stories.isLoaded && stories.stories.count > 0 ) {        StoryDetailViewController *controller = [[StoryDetailViewController alloc] initWithStories:stories.stories andIndex:indexPath.row andProject:project];        
        [self.navigationController pushViewController:controller animated:YES];
      [controller release];
    }
}


-(IBAction)addStory:(id)sender {
    AddStoryViewController *controller = [[AddStoryViewController alloc] initWithProject:project];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}


- (IBAction)refresh:(id)sender {  
    [self showHUD];
    [stories reloadStories];
}



#pragma mark Editing

- (void)edit:(id)sender {
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(cancel:)] autorelease];    
    [self.storiesTableView setEditing:TRUE animated:YES];
}
- (void)cancel:(id)sender {
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit:)] autorelease];    
    [self.storiesTableView setEditing:FALSE animated:YES];
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
 
        PivotalStory *story = [stories.stories objectAtIndex:indexPath.row];
        [self deleteStory:story];
        
    } 
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
#ifdef LOG_NETWORK    
    NSLog(@" Response: '%@'", [request responseString]);
#endif
    NSError *error = [request error];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;    
    [self hideHUD];
    if ( error ) {
        UIAlertView *alert;        
        alert = [[UIAlertView alloc] initWithTitle:@"Error Deleting Story" message:@"There was a problem deleting this story. Please try again later" delegate:self cancelButtonTitle:@"okay" otherButtonTitles: nil];
        [alert show];
        [alert release];            
    }
    [pool release];        
    [self refresh:self];    

}

@end

