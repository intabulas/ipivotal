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

#import "ListSelectionController.h"
#import "LabelCell.h"

@implementation ListSelectionController

@synthesize listItems, editingItem, listTableView;

- (id)initWithKey:(NSString *)theKey andTitle:(NSString *)theTitle {
    [super init];
    self.navigationItem.title = theTitle;
    key = [theKey retain];
    return self;
}

- (void)dealloc {
    [listItems release]; listItems = nil;
    [listTableView release]; listTableView = nil;
    [editingItem  release]; editingItem = nil;
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
    NSIndexPath *tableSelection = [listTableView indexPathForSelectedRow];
	[listTableView deselectRowAtIndexPath:tableSelection animated:NO];
    [listTableView reloadData];
}


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [editingItem setValue:[listItems objectAtIndex:indexPath.row] forKey:key];
    [self.navigationController popViewControllerAnimated:YES];
    return indexPath;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; 
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [listItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LabelCell *cell = (LabelCell*)[listTableView dequeueReusableCellWithIdentifier:kIdentifierLabelCell];
    if (cell == nil) {
        cell = [[[LabelCell alloc] initWithFrame:CGRectZero reuseIdentifier:kIdentifierLabelCell] autorelease];
    }

    [cell.cellLabel setText:[listItems objectAtIndex:indexPath.row]];
        
    NSObject *sobject = [editingItem valueForKey:key];
    if ( [sobject isKindOfClass:[NSNumber class]] ) {
        NSInteger index = [(NSNumber*)sobject integerValue];
        [cell setAccessoryType:(indexPath.row == index ) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone ];
        
    } else {
        
      [cell setAccessoryType:([[listItems objectAtIndex:indexPath.row] isEqualToString:[editingItem valueForKey:key]]) ? 
        UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone];
    }
        
    return cell;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}

@end

