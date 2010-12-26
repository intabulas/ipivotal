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

#import "IterationStoryCell.h"
#import "UILabel+Alignment.h"


@implementation IterationStoryCell

@synthesize typeImage, storyLabel, statusLabel, story, commentImage, ownerLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        typeImage = [[UIImageView alloc] initWithFrame:CGRectMake(4.0f, 6.0f, 20.0f, 20.0f)];
        typeImage.backgroundColor = [UIColor clearColor];
        
        storyLabel = [[UILabel alloc] initWithFrame:CGRectMake(33.0f, 3.0f, (self.contentView.frame.size.width - 56.0f) , 40.0f)];
        storyLabel.autoresizingMask = UIViewAutoresizingNone;
        storyLabel.backgroundColor = [UIColor clearColor];
        storyLabel.highlightedTextColor = [UIColor whiteColor];
        storyLabel.font = [UIFont  fontWithName:@"Helvetica-Bold" size:15.0f];
        storyLabel.textColor = [UIColor blackColor];
        [storyLabel setNumberOfLines:5];
        [storyLabel setLineBreakMode:UILineBreakModeWordWrap];
        storyLabel.textAlignment = UITextAlignmentLeft;
        
        statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(33.0f, 44, (self.contentView.frame.size.width - 66.0f) , 15.0f)];
        statusLabel.autoresizingMask = UIViewAutoresizingNone;
        statusLabel.backgroundColor = [UIColor clearColor];
        statusLabel.highlightedTextColor = [UIColor whiteColor];
        statusLabel.font = [UIFont  fontWithName:@"Helvetica" size:11.0f];
        statusLabel.textColor = [UIColor blackColor];
        statusLabel.textAlignment = UITextAlignmentLeft;
        
        ownerLabel = [[UILabel alloc] initWithFrame:CGRectMake(33.0f, 28.0f, (self.contentView.frame.size.width - 100.0f) , 15.0f)];
        ownerLabel.autoresizingMask = UIViewAutoresizingNone;
        ownerLabel.backgroundColor = [UIColor clearColor];
        ownerLabel.highlightedTextColor = [UIColor whiteColor];
        ownerLabel.font = [UIFont  fontWithName:@"Helvetica" size:13.0f];
        ownerLabel.textColor = [UIColor blackColor];
        ownerLabel.textAlignment = UITextAlignmentRight;
        
        
        //        commentImage = [[UIImageView alloc] initWithFrame:CGRectMake(275.0f, 28.0f, 16.0f, 16.0f)];
        commentImage = [[UIImageView alloc] initWithFrame:CGRectMake(6, 44, 16.0f, 16.0f)];        
        commentImage.image = [UIImage imageNamed:kIconComment];
        commentImage.backgroundColor = [UIColor clearColor];
        [commentImage setHidden:TRUE];
        
        
        UIView* backgroundView = [ [ [ UIView alloc ] initWithFrame:CGRectZero ] autorelease ];
        self.backgroundView = backgroundView;
        
        
        [self.contentView addSubview:typeImage];
        [self.contentView addSubview:storyLabel];        
        [self.contentView addSubview:statusLabel];      
        [self.contentView addSubview:commentImage];
        // [self.contentView addSubview:ownerLabel];
        
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)setStory:(PivotalStory *)theStory {
    
    statusLabel.textColor = [UIColor blackColor];
    storyLabel.textColor = [UIColor blackColor];
    
    storyLabel.text = theStory.name;
    [storyLabel alignTop];
    
    NSString *statusFormat = [NSString stringWithFormat:@"%@, %d point(s), owned by: %@", theStory.currentState, theStory.estimate, [theStory storyOwner]];
    
    [statusLabel setText:statusFormat];
    //        statusLabel.text = theStory.currentState;
    UIColor *theColor;
    
    if ( [theStory.currentState hasPrefix:kStateAccepted] ) {
        theColor = [UIColor colorWithRed:219.0/255.0 green:235.0/255.0 blue:209.0/255.0 alpha:1.0];
    } else if ( [theStory.currentState hasPrefix:kStateStarted] || [theStory.currentState hasPrefix:kStateDelivered] || [theStory.currentState hasPrefix:kStateFinished] ) {
        theColor = [UIColor colorWithRed:239.0/255.0 green:240.0/255.0 blue:198.0/255.0 alpha:1.0];            
        //        } else if ( [theStory.currentState hasPrefix:kStateUnStarted] &&  [theStory.storyType hasPrefix:kStateRelease] ) {
    } else if ( [theStory.storyType hasPrefix:kStateRelease] ) {            
        theColor = [UIColor colorWithRed:64.0/255.0 green:122.0/255.0 blue:165.0/255.0 alpha:1.0];       
        statusLabel.textColor = [UIColor whiteColor];
        storyLabel.textColor = [UIColor whiteColor];
        
        //                theColor = [UIColor colorWithRed:145.0/255.0 green:49.0/255.0 blue:50.0/255.0 alpha:1.0];        			
    } else if ( [theStory.currentState hasPrefix:kStateUnScheduled] ) {
        theColor = [UIColor colorWithRed:229.0/255.0 green:239.0/255.0 blue:248.0/255.0 alpha:1.0];        
        
    } else {
        theColor = [UIColor whiteColor];
    }
    
    
    if ( [theStory.storyType hasPrefix:kMatchBug] ) {    
        typeImage.image = [UIImage imageNamed:kIconTypeBug];        
    } else if ( [theStory.storyType hasPrefix:kMatchFeature] ) {
        typeImage.image = [UIImage imageNamed:kIconTypeFeature];
    } else if ( [theStory.storyType hasPrefix:kMatchChore] ) {
        typeImage.image = [UIImage imageNamed:kIconTypeChore];
        
    } else if ( [theStory.storyType hasPrefix:kMatchRelease] ) {
        typeImage.image = [UIImage imageNamed:kIconTypeRelease];        
    }
    
    [ownerLabel setText:theStory.owner];
    
    [commentImage setHidden:( [theStory.comments count] == 0 )];        
    [self.backgroundView setBackgroundColor:theColor]; 
}


- (void)dealloc {
    [commentImage release];
    [typeImage release]; 
    [storyLabel release]; 
    [statusLabel release]; 
    [ownerLabel release];
    [super dealloc];
}


@end