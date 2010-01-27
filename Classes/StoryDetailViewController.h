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


#import <UIKit/UIKit.h>

@class PivotalStory, PivotalProject;
@interface StoryDetailViewController : UIViewController <UITableViewDelegate, UIActionSheetDelegate, UIAlertViewDelegate> {
    PivotalStory *story;
    PivotalProject *project;
    @private    
    IBOutlet UITableView *storyTableView;
    IBOutlet UIView *tableHeaderView;
    IBOutlet UITableViewCell *commentsCell;
    IBOutlet UITableViewCell *ownerCell;
    IBOutlet UITableViewCell *requestorCell;
    IBOutlet UITableViewCell *descriptionCell;
    IBOutlet UITableViewCell *stateCell;  
    IBOutlet UILabel *storyOwner;
    IBOutlet UILabel *storyState;
    IBOutlet UILabel *storyRequestor;
    IBOutlet UITextView *storyDescription;    
    IBOutlet UILabel *storyName;
    IBOutlet UILabel *commentsLabel;

    IBOutlet UILabel *estimate;
    IBOutlet UIImageView *typeIcon;
    IBOutlet UIImageView *estimateIcon;
    
}

- (id)initWithStory:(PivotalStory *)theStory;
- (IBAction)showActions:(id)sender;
- (id)initWithStory:(PivotalStory *)theStory andProject:(PivotalProject *)theProject;
- (void)toggleStoryState:(NSString *)newState ;

@property (nonatomic,retain) PivotalStory* story;
@property (nonatomic,retain) PivotalProject *project;
@property (nonatomic,retain) IBOutlet UITableView *storyTableView;


@end
