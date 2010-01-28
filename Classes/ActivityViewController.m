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
#import "ActivityItemCell.h"
#import "PivotalProject.h"
#import "NSDate+Nibware.h"
#import "MBProgressHUD.h"

@implementation ActivityViewController

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
	[loadingActivitiesCell release];
	[noActivitiesCell release];
	[activities removeObserver:self forKeyPath:kResourceStatusKeyPath];
	[activities release];
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];

    activities = [[PivotalActivities alloc] initWithProject:project];
	[activities addObserver:self forKeyPath:kResourceStatusKeyPath options:NSKeyValueObservingOptionNew context:nil];

	if ( !activities.isLoaded) {  
        [self displayHUD];
        [activities loadActivities];
    }
}

- (void)displayHUD {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    NSLog(@"%@", window);
    HUD = [[MBProgressHUD alloc] initWithWindow:window];
    [window addSubview:HUD];
    HUD.delegate = self;
    [HUD setLabelText:@"Loading"];
    [HUD  showUsingAnimation:YES];    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"Activity";
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:kResourceStatusKeyPath]) {
        PivotalActivities *theActivities = (PivotalActivities *)object;
        if ( theActivities.isLoading) {
        } else {      
            [HUD hideUsingAnimation:YES];
     		[self.tableView reloadData];
        }        
	}    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)refresh:(id)sender {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    NSLog(@"%@", window);
    HUD = [[MBProgressHUD alloc] initWithWindow:window];
    [window addSubview:HUD];
    HUD.delegate = self;
    [HUD setLabelText:@"Loading"];
    [HUD  showUsingAnimation:YES];    
    [activities reloadActivities];
    [self.tableView reloadData];   	
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 	( activities.isLoading || activities.activities.count == 0) ? 1 : activities.activities.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	
	if ( !activities.isLoaded) return loadingActivitiesCell;
	if ( activities.isLoaded && activities.activities.count == 0 ) return noActivitiesCell;
	
	
    static NSString *CellIdentifier = @"ActivityItemCell";
    
    ActivityItemCell *cell = (ActivityItemCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[ActivityItemCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    [cell setActivity:[activities.activities objectAtIndex:indexPath.row]];
//    
//    if ((indexPath.row % 2) == 0) {
//         cell.backgroundView.backgroundColor = [UIColor greenColor];
//    } else {
//         cell.backgroundView.backgroundColor = [UIColor clearColor];        
//    }
    
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   // @todo
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 60.0f;
}


#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    [HUD release];
}

@end

