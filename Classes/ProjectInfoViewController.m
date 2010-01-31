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

#import "ProjectInfoViewController.h"
#import "PivotalProject.h"
#import "TitleLabelCell.h"
#import "NSDate+Nibware.h"

@implementation ProjectInfoViewController
@synthesize project, projectTableView;


- (id)initWithProject:(PivotalProject *)theProject {
	[super initWithNibName:@"ProjectInfoViewController" bundle:nil];
    
    self.project = theProject;
    return self;
}


- (void)dealloc {
    [project release];
    [projectTableView release];
    [super dealloc];
}


- (void)viewDidLoad {
    self.navigationItem.title = @"Information";
    
    [super viewDidLoad];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return 15;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Project Detail Information";
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row; 
    NSInteger section = indexPath.section;
    
    
    TitleLabelCell *cell = (TitleLabelCell*)[tableView dequeueReusableCellWithIdentifier:@"TitleLabelCell"];
    if (cell == nil) {
        cell = [[[TitleLabelCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"TitleLabelCell"] autorelease];
    }
  
    if ( section == 0 && row ==  0 ) { cell.titleLabel.text = @"Name";                cell.contentLabel.text = project.name; }
    if ( section == 0 && row ==  1 ) { cell.titleLabel.text = @"Id";                  cell.contentLabel.text = [NSString stringWithFormat:@"%d", project.projectId]; }    
    if ( section == 0 && row ==  2 ) { cell.titleLabel.text = @"Iteration Length";    cell.contentLabel.text = [NSString stringWithFormat:@"%d", project.iterationLength]; }    
    if ( section == 0 && row ==  3 ) { cell.titleLabel.text = @"Week Start";          cell.contentLabel.text = project.weekStartDay; }    
    if ( section == 0 && row ==  4 ) { cell.titleLabel.text = @"Point Scale";         cell.contentLabel.text = project.pointScale; }    
    if ( section == 0 && row ==  5 ) { cell.titleLabel.text = @"Velocity Scheme";     cell.contentLabel.text = project.velocityScheme; }    
    if ( section == 0 && row ==  6 ) { cell.titleLabel.text = @"Current Velocity";    cell.contentLabel.text = [NSString stringWithFormat:@"%d", project.currentVelocity]; }    
    if ( section == 0 && row ==  7 ) { cell.titleLabel.text = @"Initial Velocity";    cell.contentLabel.text = [NSString stringWithFormat:@"%d", project.initialVelocity]; }   
    if ( section == 0 && row ==  8 ) { cell.titleLabel.text = @"Done Iterations";     cell.contentLabel.text = [NSString stringWithFormat:@"%d", project.numberDoneIterations]; }    
    
    
    
    if ( section == 0 && row ==  9 ) { 
        cell.titleLabel.text = @"Allows Attachments"; 
        cell.contentLabel.text = project.allowsAttachments ? @"YES" : @"NO";
    }    
    if ( section == 0 && row == 10 ) { 
        cell.titleLabel.text = @"Public";                    
        cell.contentLabel.text = project.publicProject ? @"YES" : @"NO";
    }    
    if ( section == 0 && row == 11 ) {
        cell.titleLabel.text = @"Use HTTPS?";                
        cell.contentLabel.text = project.useHttps ? @"YES" : @"NO";
    } 
    if ( section == 0 && row == 12 ) {
        cell.titleLabel.text = @"Estimate Bugs/Chores";          
        cell.contentLabel.text = project.estimateBugsAndChores ? @"YES" : @"NO";
    }    
    if ( section == 0 && row == 13 ) {
        cell.titleLabel.text = @"Commit Mode";               
        cell.contentLabel.text = project.commitMode ? @"YES" : @"NO";
    }    
    if ( row == 14 ) {
        cell.titleLabel.text = @"Last Activity";             
        cell.contentLabel.text = [project.lastActivityAt prettyDate];
    }    
    
    return  cell;
  
}





@end
