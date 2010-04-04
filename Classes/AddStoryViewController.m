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

#import "AddStoryViewController.h"
#import "LabelCell.h"
#import "ImageLabelCell.h"
#import "PivotalStory.h"
#import "ListSelectionController.h"
#import "ASIHTTPRequest.h"
#import "PivotalResource.h"
#import "PivotalMembership.h"
#import "LabelInputCell.h"

@implementation AddStoryViewController

@synthesize story, editingDictionary;

- (id)initWithProject:(PivotalProject *)theProject andStory:(PivotalStory *)theStory {
    [self initWithProject:theProject];
    [self.story release];
    self.story = theStory;
    
    self.story.storyType = [self.story.storyType capitalizedString];
    editing = YES;    
    return self;
}

- (id)initWithProject:(PivotalProject *)theProject {
    [super init];
    project = theProject;
    self.story = [[PivotalStory alloc] init];
    editing = NO;
    
    return self;
}

- (void)dealloc {
    [editingDictionary release]; editingDictionary = nil;
    [story release]; story = nil;
    [storyTableView release]; storyTableView = nil;
    [textField release]; textField = nil;
    [storyNameCell release]; storyNameCell = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveStory:)];
    [storyNameCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [textField becomeFirstResponder];
}

- (void) saveStory:(id)sender {

    self.story.name = textField.text;
    [textField resignFirstResponder];

    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [self showHUDWithLabel:kLabelSaving];        
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;    
    NSString *urlString;
    if ( editing ) {
        urlString = [NSString stringWithFormat:kUrlUpdateStory, project.projectId, story.storyId];                            
    } else {
        urlString = [NSString stringWithFormat:kUrlAddStory, project.projectId];                            
    }
	NSURL *followingURL = [NSURL URLWithString:urlString];    
    ASIHTTPRequest *request = [PivotalResource authenticatedRequestForURL:followingURL];
    NSString *newstory = [self.story to_xml];
    if (editing) {
        [request setRequestMethod:@"PUT"];
    }
    
    [request addRequestHeader:kHttpContentType value:kHttpMimeTypeXml];
    [request setPostBody:[[[NSMutableData alloc] initWithData:[newstory dataUsingEncoding:NSUTF8StringEncoding]]autorelease]];
    [request startSynchronous];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;    
    [self hideHUD];
    [pool release];    

    [self.navigationController popViewControllerAnimated:YES];    

    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ( editingDictionary == nil ) {
       editingDictionary = [[NSMutableDictionary alloc] init];        
       [editingDictionary setObject:kTypeFeature forKey:kKeyType];
       [editingDictionary setObject:kDefaultStoryTitle forKey:kKeyStoryName];
       [editingDictionary setObject:kLabelSetOwner forKey:kKeyOwned];
       [editingDictionary setObject:[NSNumber numberWithInteger:0] forKey:kKeyEstimate];    
        
        if ( editing ) {
            self.title = kLabelEditingStory;
            [textField setText:self.story.name];
            [editingDictionary setObject:self.story.storyType forKey:kKeyType];
            [editingDictionary setObject:self.story.name forKey:kKeyStoryName];
            [editingDictionary setObject:[NSNumber numberWithInteger:self.story.estimate] forKey:kKeyEstimate];  
            if ( [self.story.owner length] != 0 ) {
               [editingDictionary setObject:self.story.owner forKey:kKeyOwned]; 
            } else {
                [editingDictionary setObject:kLabelSetOwner forKey:kKeyOwned];
            }
        }        
        
        
    }
    
    self.story.name           = textField.text;
    self.story.owner          = [editingDictionary valueForKey:kKeyOwned];
    self.story.storyType      = [editingDictionary valueForKey:kKeyType];

    NSNumber *estimateNumber  = [editingDictionary valueForKey:kKeyEstimate];

    self.story.estimate       = [estimateNumber integerValue];
    self.title = kLabelAddStory;
    
    [storyTableView reloadData];
//    [textField becomeFirstResponder];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; 
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 5;  // if we have assignment 
    return 4;    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;    
    
    if (  row == 0 ) { return storyNameCell; }
    
    if ( row == 1 ) {
        ImageLabelCell *cell = (ImageLabelCell*)[tableView dequeueReusableCellWithIdentifier:kIdentifierImageLabelCell];
        if (cell == nil) {
            cell = [[[ImageLabelCell alloc] initWithFrame:CGRectZero reuseIdentifier:kIdentifierImageLabelCell] autorelease];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;      
        
        [cell.cellLabel setText:story.storyType];   
        
        if ( [story.storyType hasPrefix:kTypeBug] ) {    
            [cell setImage:[UIImage imageNamed:kIconTypeBug]];        
        } else if ( [self.story.storyType hasPrefix:kTypeFeature] ) {
            [cell setImage:[UIImage imageNamed:kIconTypeFeature]];
        } else if ( [self.story.storyType hasPrefix:kTypeChore] ) {
            [cell setImage:[UIImage imageNamed:kIconTypeChore]];        
        } else if ( [self.story.storyType hasPrefix:kTypeRelease] ) {
            [cell setImage:[UIImage imageNamed:kIconTypeRelease]];
            
        }          
        
        return  cell;            
    }
    
    if ( row == 2 ) {
        ImageLabelCell *cell = (ImageLabelCell*)[tableView dequeueReusableCellWithIdentifier:kIdentifierImageLabelCell];
        if (cell == nil) {
            cell = [[[ImageLabelCell alloc] initWithFrame:CGRectZero reuseIdentifier:kIdentifierImageLabelCell] autorelease];
        }
        [cell setContentMode:UIViewContentModeBottom];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;        
        [cell.cellLabel setText:[NSString stringWithFormat:kFormatPoints, story.estimate]];   
        
        if ( story.estimate == 0 ) [cell setImage:[UIImage imageNamed:kIconEstimateNone]];
        if ( story.estimate == 1 ) [cell setImage:[UIImage imageNamed:kIconEstimateOnePoint]];
        if ( story.estimate == 2 ) [cell setImage:[UIImage imageNamed:kIconEstimateTwoPoints]];    
        if ( story.estimate == 3 ) [cell setImage:[UIImage imageNamed:kIconEstimateThreePoints]];               
                                    
        return  cell;            
    }
    

    if (  row == 3  ) {  /// 4 if there is assignment
        LabelInputCell *cell = (LabelInputCell*)[tableView dequeueReusableCellWithIdentifier:kIdentifierLabelInputCell];
        if (cell == nil) {
            cell = [[[LabelInputCell alloc] initWithFrame:CGRectZero reuseIdentifier:kIdentifierLabelInputCell] autorelease] ;
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;        
        [cell.cellLabel setText:@"Owner:"];    
        [cell.cellValue setText:story.owner];            
        return  cell;        
    }    
    
    
    return nil;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
            
    if (indexPath.row == 1) {
        ListSelectionController *controller = [[ListSelectionController alloc] initWithKey:kKeyType andTitle:@"Story Type"];
        controller.listItems = [[NSArray alloc] initWithObjects:kTypeFeature, kTypeBug, kTypeChore, kTypeRelease, nil];
                        
        controller.editingItem = editingDictionary;
        [editingDictionary setValue:story.storyType forKey:kKeyType];
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    }
    
//    if( indexPath.row == 2 && [story.storyType hasPrefix:kTypeFeature]) {
      if( indexPath.row == 2 ) {

        ListSelectionController *controller = [[ListSelectionController alloc] initWithKey:kKeyEstimate andTitle:@"Point Estimate"];
        controller.listItems = [[NSArray alloc] initWithObjects:@"0 Points", @"1 Point", @"2 Points", @"3 Points", nil];
        
        controller.editingItem = editingDictionary;
        [editingDictionary setValue:[NSNumber numberWithInteger:story.estimate] forKey:kKeyEstimate];
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    }
    if( indexPath.row == 3 ) {
        
        ListSelectionController *controller = [[ListSelectionController alloc] initWithKey:kKeyOwned andTitle:@"Story Owner"];
        
        NSMutableArray *members = [[NSMutableArray alloc]init];
        for (PivotalMembership *themember in project.members) {
            [members addObject:[themember memberName]];
        }    
        controller.listItems = members;
        
        controller.editingItem = editingDictionary;
        [editingDictionary setValue:story.owner forKey:kKeyOwned];
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    }    
    
    return indexPath;
}

#pragma mark UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	[textField resignFirstResponder];
	return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}


@end

