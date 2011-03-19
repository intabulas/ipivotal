//
//	Copyright (c) 2008-2011, Mark Lussier
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

#import "CommentsController.h"
#import "PivotalNote.h"
#import "CommentCell.h"
#import "PivotalStory.h"
#import "PivotalProject.h"
#import "CommentHeaderView.h"
#import "AddCommentController.h"

@implementation CommentsController

-(id)initWithProject:(PivotalProject *)theProject andStory:(PivotalStory *)theStory {
       [super initWithNibName:@"CommentsController" bundle:nil];
    project = theProject;
    story = theStory;
    comments = story.comments;    
    return self;

}


-(id)initWithComments:(NSArray *)theComments {

    [super initWithNibName:@"CommentsController" bundle:nil];
    
    comments = theComments;
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [commentTableView reloadData];
    if ( comments.count > 0 ) {
      [commentTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(story.comments.count - 1 ) inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(composeReply:)];

    
    [self setTitle:kLabelComment];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;//[comments count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [comments count]; //1;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Comments";    
}
//- (UIView *)tableView: (UITableView *)tableView viewForHeaderInSection: (NSInteger)section {
//     CommentHeaderView* headerView = [[[CommentHeaderView alloc] initWithFrame:CGRectMake(0, 0, commentTableView.bounds.size.width, 55)] autorelease];   
//     [headerView setNote:[comments objectAtIndex:section]];
//     return headerView; 
//}
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = kIdentifierCommentCell;
    
    CommentCell *cell = (CommentCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:kIdentifierCommentCell owner:self options:nil];        
        cell = commentCell;
    }
    
    PivotalNote *note = (PivotalNote *)[comments objectAtIndex:indexPath.row];

    [cell setComment:note];
    // Set up the cell...
	
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIFont *font = [commentTextView font];
    if ( !font ) {
        font = [UIFont fontWithName:@"Helvetica" size:14];
    }
    
    PivotalNote *note = (PivotalNote *)[comments objectAtIndex:indexPath.section];

    
    CGSize detailTextSize = [note.text sizeWithFont:font
                             constrainedToSize:CGSizeMake(310.0f, CGFLOAT_MAX)
                             lineBreakMode:UILineBreakModeWordWrap];

    return detailTextSize.height + 25.0f + 11.0f;    
    

}



- (void)dealloc {
    [super dealloc];
}


#pragma mark Add Comments

-(void)composeReply:(id)sender {
    AddCommentController *addController = [[AddCommentController alloc] createCommentforStory:story andProject:project];
    [self.navigationController pushViewController:addController animated:YES];
    [addController release];
    
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}


@end

