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
#import "NSDate+Nibware.h"
#import "DynamicCell.h"
#import "PivotalMembership.h"

@implementation ProjectInfoViewController

@synthesize project, projectTableView;

static UIFont *boldFont;


- (id)initWithProject:(PivotalProject *)theProject {
	[super initWithNibName:@"ProjectInfoViewController" bundle:nil];
    
    self.project = theProject;
    return self;
}


- (void)dealloc {
    [project release]; project = nil;
    [projectTableView release]; projectTableView = nil;
    [super dealloc];
}


- (void)viewDidLoad {
    self.navigationItem.title = kLabelInformation;
    
    [super viewDidLoad];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (CGFloat) tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    UITableViewCell* cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return [cell respondsToSelector:@selector(height)] ? 
    [[cell performSelector:@selector(height)] floatValue] : 
    tableView.rowHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  (section == 0 ) ?  15 :  self.project.members.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return ( section == 0 ) ? kLabelProjectDetailInfo : kLabelProjectMembers;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row; 
    NSInteger section = indexPath.section;
    
    static float defaultFontSize = 14.0;
    if ( boldFont == nil ) {
        boldFont = [[UIFont fontWithName:@"Helvetica-Bold" size:defaultFontSize] retain];        
    }
    
    
    DynamicCell *cell = (DynamicCell*)[tableView dequeueReusableCellWithIdentifier:@"InfoCell"];
    if ( cell == nil ) {
        cell = [DynamicCell cellWithReuseIdentifier:@"InfoCell"];
        cell.defaultFont = [UIFont fontWithName:@"Helvetica" size:defaultFontSize];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    }
    [cell reset];
    
    
    if ( section == 0 ) {
        
      switch(row) {
              
          case 0:
              [cell addLabelWithText:kLabelName];
              [cell addLabelWithText:project.name andFont:boldFont onNewLine:NO rightAligned:YES];
              break;
          case 1:
              [cell addLabelWithText:kLabelId];
              [cell addLabelWithText:[NSString stringWithFormat:kFormatNumber, project.projectId] andFont:boldFont onNewLine:NO rightAligned:YES];
              break;              
          case 2: 
              [cell addLabelWithText:kLabelIterationLength];
              [cell addLabelWithText:[NSString stringWithFormat:kFormatNumber, project.iterationLength] andFont:boldFont onNewLine:NO rightAligned:YES];
              break;              
          case 3: 
              [cell addLabelWithText:kLabelWeekStart];
              [cell addLabelWithText:project.weekStartDay andFont:boldFont onNewLine:NO rightAligned:YES];
              break;              
          case 4: 
              [cell addLabelWithText:kLabelPointScale];
              [cell addLabelWithText:project.pointScale andFont:boldFont onNewLine:NO rightAligned:YES];
              break;              
          case 5: 
              [cell addLabelWithText:kLabelVelocityScheme];
              [cell addLabelWithText:project.velocityScheme andFont:boldFont onNewLine:NO rightAligned:YES];
              break;              
          case 6: 
              [cell addLabelWithText:kLabelCurrentVelocity];
              [cell addLabelWithText:[NSString stringWithFormat:kFormatNumber, project.currentVelocity] andFont:boldFont onNewLine:NO rightAligned:YES];
              break;              
          case 7: 
              [cell addLabelWithText:kLabelInitialVelocity];
              [cell addLabelWithText:[NSString stringWithFormat:kFormatNumber, project.initialVelocity] andFont:boldFont onNewLine:NO rightAligned:YES];               
              break;              
          case 8: 
              [cell addLabelWithText:kLabelDoneIterations];
              [cell addLabelWithText:[NSString stringWithFormat:kFormatNumber, project.numberDoneIterations] andFont:boldFont onNewLine:NO rightAligned:YES];
              break;              
          case 9:
               [cell addLabelWithText:kLabelAllowsAttachments];
               [cell addLabelWithText:project.allowsAttachments ? kLabelYes : kLabelYes andFont:boldFont onNewLine:NO rightAligned:YES];
              break;              
          case 10:
              [cell addLabelWithText:kLabelPublic];
              [cell addLabelWithText:project.publicProject ? kLabelYes : kLabelYes andFont:boldFont onNewLine:NO rightAligned:YES];
              break;              
          case 11:
              [cell addLabelWithText:kLabelUseHttps];
              [cell addLabelWithText:project.useHttps ? kLabelYes : kLabelYes andFont:boldFont onNewLine:NO rightAligned:YES];
              break;              
          case 12:
              [cell addLabelWithText:kLabelEstimateBugsChores];
              [cell addLabelWithText:project.estimateBugsAndChores ? kLabelYes : kLabelYes andFont:boldFont onNewLine:NO rightAligned:YES];
              break;              
          case 13:
              [cell addLabelWithText:kLabelCommitMode];
              [cell addLabelWithText:project.commitMode ? kLabelYes : kLabelYes andFont:boldFont onNewLine:NO rightAligned:YES];
              break;              
          case 14:
              [cell addLabelWithText:kLabelLastActivity];
              [cell addLabelWithText:[project.lastActivityAt prettyDate] andFont:boldFont onNewLine:NO rightAligned:YES];
              break;              
      }
    } else {
        PivotalMembership *member = (PivotalMembership*)[self.project.members objectAtIndex:row];        

        [cell addLabelWithText:[NSString stringWithFormat:kFormatMemberCellNameIntitials, [member memberName], [member initials]] andFont:boldFont onNewLine: NO];
        [cell addLabelWithText:[NSString stringWithFormat:kFormatMemberCellRole, [member role]] andFont:[UIFont fontWithName:@"Helvetica" size:12.0] onNewLine: YES];
         
    }
    
    [cell prepare];
    
    return  cell;
  
}





@end
