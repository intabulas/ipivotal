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


@implementation IterationStoryCell

@synthesize typeImage, estimateImage, storyLabel, statusLabel, story, commentsLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        
                typeImage = [[UIImageView alloc] initWithFrame:CGRectMake(4.0f, 12.0f, 20.0f, 20.0f)];
                typeImage.backgroundColor = [UIColor clearColor];
                
                estimateImage = [[UIImageView alloc] initWithFrame:CGRectMake(30.0f, 9.0f, 12.0f, 12.0f)];        
                estimateImage.contentMode =  UIViewContentModeBottom;

        
                
                storyLabel = [[UILabel alloc] initWithFrame:CGRectMake(45.0f, 3.0f, (self.contentView.frame.size.width - 65.0f) , 25.0f)];
                storyLabel.autoresizingMask = UIViewAutoresizingNone;
                storyLabel.backgroundColor = [UIColor clearColor];
                storyLabel.highlightedTextColor = [UIColor whiteColor];
                storyLabel.font = [UIFont  systemFontOfSize:14.0f];
                storyLabel.textColor = [UIColor blackColor];
                storyLabel.textAlignment = UITextAlignmentLeft;
        
                
                statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(31.0f, 30.0f, (self.contentView.frame.size.width - 66.0f) , 15.0f)];
                statusLabel.autoresizingMask = UIViewAutoresizingNone;
                statusLabel.backgroundColor = [UIColor clearColor];
                statusLabel.highlightedTextColor = [UIColor whiteColor];
                statusLabel.font = [UIFont  systemFontOfSize:13.0f];
                statusLabel.textColor = [UIColor blackColor];
                statusLabel.textAlignment = UITextAlignmentLeft;

                commentsLabel = [[UILabel alloc] initWithFrame:CGRectMake(230.0f, 30.0f, (self.contentView.frame.size.width - 10.0f) , 15.0f)];
                commentsLabel.autoresizingMask = UIViewAutoresizingNone;
                commentsLabel.backgroundColor = [UIColor clearColor];
                commentsLabel.highlightedTextColor = [UIColor whiteColor];
                commentsLabel.font = [UIFont  systemFontOfSize:13.0f];
                commentsLabel.textColor = [UIColor blackColor];
                commentsLabel.textAlignment = UITextAlignmentLeft;
            
                
                
                UIView* backgroundView = [ [ [ UIView alloc ] initWithFrame:CGRectZero ] autorelease ];
                self.backgroundView = backgroundView;
                
                
                [self.contentView addSubview:typeImage];
                [self.contentView addSubview:estimateImage];        
                [self.contentView addSubview:storyLabel];        
                [self.contentView addSubview:statusLabel];      
                [self.contentView addSubview:commentsLabel];
                
                
        }
        return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
        [super setSelected:selected animated:animated];
    
        // Configure the view for the selected state
}


- (void)setStory:(PivotalStory *)theStory {
     
        NSLog(@"%@", theStory);
    
        statusLabel.textColor = [UIColor blackColor];
        storyLabel.textColor = [UIColor blackColor];
    
        storyLabel.text = theStory.name;
        statusLabel.text = theStory.currentState;
        UIColor *theColor;
            
        if ( [theStory.currentState hasPrefix:kStateAccepted] ) {
                theColor = [UIColor colorWithRed:216.0/255.0 green:238.0/255.0 blue:206.0/255.0 alpha:1.0];
        } else if ( [theStory.currentState hasPrefix:kStateStarted] || [theStory.currentState hasPrefix:kStateDelivered] ) {
                theColor = [UIColor colorWithRed:255.0/255.0 green:248.0/255.0 blue:228.0/255.0 alpha:1.0];
//        } else if ( [theStory.currentState hasPrefix:kStateUnStarted] &&  [theStory.storyType hasPrefix:kStateRelease] ) {
        } else if ( [theStory.storyType hasPrefix:kStateRelease] ) {            
            theColor = [UIColor colorWithRed:64.0/255.0 green:122.0/255.0 blue:165.0/255.0 alpha:1.0];       
			statusLabel.textColor = [UIColor whiteColor];
			storyLabel.textColor = [UIColor whiteColor];
 			
//                theColor = [UIColor colorWithRed:145.0/255.0 green:49.0/255.0 blue:50.0/255.0 alpha:1.0];        			
        } else if ( [theStory.currentState hasPrefix:kStateUnScheduled] ) {
                theColor = [UIColor colorWithRed:231.0/255.0 green:243.0/255.0 blue:250.0/255.0 alpha:1.0];        
                
        } else {
                theColor = [UIColor whiteColor];
        }
        
        estimateImage.image = [UIImage imageNamed: kIconEstimateNone];
        if ( theStory.estimate == 1 ) estimateImage.image = [UIImage imageNamed:kIconEstimateOnePoint];
        if ( theStory.estimate == 2 ) estimateImage.image = [UIImage imageNamed:kIconEstimateTwoPoints];    
        if ( theStory.estimate == 3 ) estimateImage.image = [UIImage imageNamed: kIconEstimateThreePoints];        
        
        if ([theStory.storyType hasPrefix:kStateRelease]) estimateImage.image = nil;
    
        if ( [theStory.storyType hasPrefix:kMatchBug] ) {    
                typeImage.image = [UIImage imageNamed:kIconTypeBug];        
        } else if ( [theStory.storyType hasPrefix:kMatchFeature] ) {
                typeImage.image = [UIImage imageNamed:kIconTypeFeature];
        } else if ( [theStory.storyType hasPrefix:kMatchChore] ) {
                typeImage.image = [UIImage imageNamed:kIconTypeChore];
                
        } else if ( [theStory.storyType hasPrefix:kMatchRelease] ) {
                typeImage.image = [UIImage imageNamed:kIconTypeRelease];        
        }
    
        
        if ( [theStory.comments count] > 0 ) {
            [commentsLabel setText:kLabelComments];
        } else {
            [commentsLabel setText:@""];
        }
    
        
        [self.backgroundView setBackgroundColor:theColor];
}


- (void)dealloc {
        [typeImage release];
        [estimateImage release];
        [storyLabel release];
        [statusLabel release];    
        [super dealloc];
}


@end