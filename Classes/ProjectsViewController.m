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

#import "ProjectsViewController.h"
#import "PivotalProject.h"
#import "IterationsViewController.h"
#import "ImageLabelCell.h"
#import "ProjectLabelCell.h"
#import "iPivotalAppDelegate.h"
#import "ActivityViewController.h"
#import "NSDate+Nibware.h"
#import "MBProgressHUD.h"
#import "ProjectInfoViewController.h"
#import "PlaceholderCell.h"

@implementation ProjectsViewController

@synthesize projectTableView, hudDisplayed;

- (void)dealloc {
    [projects removeObserver:self forKeyPath:kResourceStatusKeyPath];
    [projects release]; projects = nil;
    [noProjectsCell release]; noProjectsCell = nil;
    [projectTableView release]; projectTableView = nil;
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];

   
    projects = [[PivotalProjects alloc] init];
    [projects addObserver:self forKeyPath:kResourceStatusKeyPath options:NSKeyValueObservingOptionNew context:nil];
    

}

- (void)displayHUD {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    HUD = [[MBProgressHUD alloc] initWithWindow:window];
    [window addSubview:HUD];
    HUD.delegate = self;
    [HUD setLabelText:kLabelLoading];
    hudDisplayed = YES;
    [HUD  show:YES];    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = kLabelProjects;
}
- (IBAction)refreshProjectList:(id)sender; {}

- (void)reloadProjects {
	[projects reloadProjects];
}

- (void)loadProjects {
    if ( !projects.isLoaded ) [projects loadProjects];    
    [projects loadProjects];    	
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:kResourceStatusKeyPath]) {
         
        PivotalProjects *theProjects = (PivotalProjects *)object;
    
        if ( theProjects.isLoading) {
        } else {         
            [self hideHeadsUpDisplay];
     		[self.projectTableView reloadData];

        }        
	}    
}


#pragma mark Actions

- (IBAction)logout:(id)sender {
    // @TODO
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:kDefaultsApiToken];
    iPivotalAppDelegate *appdelegate = (iPivotalAppDelegate *)[[UIApplication sharedApplication]delegate];
	[appdelegate authenticate];
}


- (IBAction)refresh:(id)sender {
    [self displayHUD];
    [projects  reloadProjects];
    [self.projectTableView reloadData];     
}

- (IBAction)recentActivity:(id)sender {
    ActivityViewController *controller = [[ActivityViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];	
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  (projects.isLoading  || projects.projects.count == 0) ? 1 : projects.projects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if ( !projects.isLoaded && !self.hudDisplayed) { [self displayHUD]; } 
    
    iPivotalAppDelegate *appdelegate = (iPivotalAppDelegate *)[[UIApplication sharedApplication]delegate];

    if ( [appdelegate hasNoInternetConnectivity]) return noProjectsCell;
	if (projects.isLoaded && projects.projects.count == 0) return noProjectsCell;
	
    ProjectLabelCell *cell = (ProjectLabelCell*)[tableView dequeueReusableCellWithIdentifier:kIdentifierProjectLabelCell];
    if (cell == nil) {
        cell = [[[ProjectLabelCell alloc] initWithFrame:CGRectZero reuseIdentifier:kIdentifierProjectLabelCell] autorelease];
    }
    
    if ( !projects.isLoaded) { 
        PlaceholderCell *cell = (PlaceholderCell*)[tableView dequeueReusableCellWithIdentifier:kIdentifierPlaceholderCell];
        if (cell == nil) {
            cell = [[[PlaceholderCell alloc] initWithFrame:CGRectZero reuseIdentifier:kIdentifierPlaceholderCell] autorelease];
        }
        return  cell;
        
    }        
    
    
    PivotalProject *pp = [projects.projects objectAtIndex: indexPath.row];
    [cell.cellLabel setText:pp.name];
    [cell.lastUpdated setText:[NSString stringWithFormat:kLableProjectActivity, [pp.lastActivityAt prettyDate]]];
    	
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
	
    return cell;       
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath { 
    if ( projects.isLoaded && projects.projects.count > 0 ) {
       PivotalProject *project = [projects.projects objectAtIndex:indexPath.row];
	   IterationsViewController *controller = [[IterationsViewController alloc] initWithProject:project];  
	   [self.navigationController pushViewController:controller animated:YES];
  	   [controller release];    
    }
}


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if ( projects.isLoaded && projects.projects.count > 0 ) {
        PivotalProject *project = [projects.projects objectAtIndex:indexPath.row];
        ProjectInfoViewController *controller = [[ProjectInfoViewController alloc] initWithProject:project];  
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];    
    }
}




- (void)hideHeadsUpDisplay {
    if ( hudDisplayed ) {
      hudDisplayed = NO;
      [HUD hide:YES];
    }
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden {
    // Remove HUD from screen when the HUD was hidded
    hudDisplayed = NO;
    [HUD removeFromSuperview];
    [HUD release];
}


@end

