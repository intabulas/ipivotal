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

#import "ActivityViewController.h"
#import "PivotalProject.h"
#import "NSDate+Nibware.h"
#import "PlaceholderCell.h"
#import "DynamicCell.h"
#import "PivotalActivity.h"

@implementation ActivityViewController

static UIFont *boldFont;


- (id)init {
    [super initWithNibName:@"ActivityViewController" bundle:nil];
    return self;
}

- (id)initWithProject:(PivotalProject *)theProject {
    [self init];
    project = theProject;
    return self;
}

- (void)dealloc {
	[noActivitiesCell release]; noActivitiesCell = nil;
	[activities removeObserver:self forKeyPath:kResourceStatusKeyPath];
	[activities release]; activities = nil;
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
	//self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];

    activities = [[PivotalActivities alloc] initWithProject:project];
	[activities addObserver:self forKeyPath:kResourceStatusKeyPath options:NSKeyValueObservingOptionNew context:nil];

	if ( !activities.isLoaded) {  
        [self showReloadAnimationAnimated:NO];
        [activities loadActivities];
    }
    
    refreshHeaderView.lastUpdatedDate = [NSDate new];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = kLabelActivity;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:kResourceStatusKeyPath]) {
        PivotalActivities *theActivities = (PivotalActivities *)object;
        if ( theActivities.isLoading) {
        } else {                  
     		[self.tableView reloadData];
			refreshHeaderView.lastUpdatedDate = [NSDate new];
            [super dataSourceDidFinishLoadingNewData];
        }        
	}    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)refresh:(id)sender {
    [activities reloadActivities];
    [self.tableView reloadData];   	
}

- (void)reloadTableViewDataSource {
	    [activities reloadActivities];
}

#pragma mark Table view methods



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 	( activities.isLoading || activities.activities.count == 0) ? 1 : activities.activities.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	
	if ( !activities.isLoaded) {
        PlaceholderCell *cell = (PlaceholderCell*)[tableView dequeueReusableCellWithIdentifier:kIdentifierPlaceholderCell];
        if (cell == nil) {
            cell = [[[PlaceholderCell alloc] initWithFrame:CGRectZero reuseIdentifier:kIdentifierPlaceholderCell] autorelease];
        }
        return  cell;         
    }
    
	if ( activities.isLoaded && activities.activities.count == 0 ) return noActivitiesCell;

    
    
    
    static float defaultFontSize = 16.0;
    if ( boldFont == nil ) {
        boldFont = [[UIFont boldSystemFontOfSize:defaultFontSize] retain];        
    } 
    
    
    DynamicCell *cell = (DynamicCell*)[tableView dequeueReusableCellWithIdentifier:@"InfoCell"];
    if ( cell == nil ) {
        cell = [DynamicCell cellWithReuseIdentifier:@"InfoCell"];
        cell.defaultFont = [UIFont systemFontOfSize:defaultFontSize];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;        
    }
    [cell reset];     

    PivotalActivity *activity = (PivotalActivity*)[activities.activities objectAtIndex:indexPath.row];
    NSMutableString *activityText = [[NSMutableString alloc] initWithString:activity.description];
    [activityText replaceOccurrencesOfString:@"\"" withString:@" " options:NSLiteralSearch range:NSMakeRange(0,[activityText length])];
	NSString *prettyDate = [activity.occuredAt prettyDate];

#if LOG_CONTENT
    NSLog(@"[PivotalActivity] Description == %@", activity.description);
#endif
    
    
    [cell addLabelWithText:activityText];
    [cell addLabelWithText:[NSString stringWithFormat:kFormatObject, prettyDate] andFont:[UIFont boldSystemFontOfSize:13.0]];
    [activityText release];
    
    [cell prepare];
    return cell;
    

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   // @todo
}

- (CGFloat) tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    UITableViewCell* cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return [cell respondsToSelector:@selector(height)] ? 
    [[cell performSelector:@selector(height)] floatValue] : 
    tableView.rowHeight;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}


@end

