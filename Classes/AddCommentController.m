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

#import "AddCommentController.h"
#import "PivotalResource.h"
#import "PivotalNote.h"


@implementation AddCommentController

- (void)dealloc {
    [note release];
    [super dealloc];
}


-(id)initWithNote:(PivotalNote *)theNote {
    [super initWithNibName:@"CommentsController" bundle:nil];
	note = [theNote retain];
    return self;    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [commentBody becomeFirstResponder];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = kLabelAddComment;
	self.tableView.tableFooterView = tableFooterView;    
    [note addObserver:self forKeyPath:kResourceSavingStatusKeyPath options:NSKeyValueObservingOptionNew context:nil];

}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:kResourceSavingStatusKeyPath]) {
		if (note.isSaving) return;
		if (note.isSaved) {
  		   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Your comment has been added to this story" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		   [alert show];
		   [alert release];
		} else if (note.error) {
		   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Request error" message:@"There was a problem adding your comment" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		   [alert show];
		   [alert release];
		}        
        saveButton.enabled = YES;
		[activityView stopAnimating];

	}
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];            
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}


- (IBAction)saveNote:(id)sender {
    [note setText:commentBody.text];
	saveButton.enabled = NO;
	[activityView startAnimating];
	[note saveNote];

}


#pragma mark -
#pragma mark Keyboard

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[commentBody resignFirstResponder];
	return YES;
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {  	
    return commentCell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 122.0f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}



@end

