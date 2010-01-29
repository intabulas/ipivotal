//
//	Copyright (c) 2008-2010 Mark Lussier
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

#import "ActivityItemCell.h"
#import "NSDate+Nibware.h"

@implementation ActivityItemCell



@synthesize activityLabel, statusLabel, activity, storyLabel; //, typeImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setAccessoryType:UITableViewCellAccessoryNone]; 
        
//        typeImage = [[UIImageView alloc] initWithFrame:CGRectMake(4.0f, 20.0f, 20.0f, 20.0f)];
//        typeImage.backgroundColor = [UIColor clearColor];
//		typeImage.image = [UIImage  imageNamed:kIconActivity];
//
//		storyLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, 18.0f, (self.contentView.frame.size.width - 55.0f) , 25.0f)];
//		storyLabel.autoresizingMask = UIViewAutoresizingNone;
//		storyLabel.backgroundColor = [UIColor clearColor];
//		storyLabel.highlightedTextColor = [UIColor whiteColor];
//		storyLabel.font = [UIFont  systemFontOfSize:12.0f];
//		storyLabel.textColor = [UIColor blackColor];
//		storyLabel.textAlignment = UITextAlignmentLeft;
        
        
        
		activityLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 2.0f, (self.contentView.frame.size.width - 15.0f) , 25.0f)];
		activityLabel.autoresizingMask = UIViewAutoresizingNone;
		activityLabel.backgroundColor = [UIColor clearColor];
		activityLabel.highlightedTextColor = [UIColor whiteColor];
		activityLabel.font = [UIFont  systemFontOfSize:12.0f];
		activityLabel.textColor = [UIColor blackColor];
		activityLabel.textAlignment = UITextAlignmentLeft;
        
        // was 38
		statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 22.0f, (self.contentView.frame.size.width - 15.0f) , 15.0f)];
		statusLabel.autoresizingMask = UIViewAutoresizingNone;
		statusLabel.backgroundColor = [UIColor clearColor];
		statusLabel.highlightedTextColor = [UIColor whiteColor];
		statusLabel.font = [UIFont  systemFontOfSize:10.0f];
		statusLabel.textColor = [UIColor blackColor];
		statusLabel.textAlignment = UITextAlignmentLeft;
		
		
		
		UIView* backgroundView = [ [ [ UIView alloc ] initWithFrame:CGRectZero ] autorelease ];
		self.backgroundView = backgroundView;
		
//		[self.contentView addSubview:typeImage];
//        [self.contentView addSubview:storyLabel];
		[self.contentView addSubview:activityLabel];        
		[self.contentView addSubview:statusLabel];                
		
		
	}
	return self;
}


- (void)dealloc {
//    [typeImage release];
	[activityLabel release];
    [storyLabel release];
	[statusLabel release];    
	[super dealloc];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {    
	[super setSelected:selected animated:animated];
}


- (void)setActivity:(PivotalActivity *)theActivity {
    NSMutableString *activityText = [[NSMutableString alloc] initWithString:theActivity.description];
    [activityText replaceOccurrencesOfString:@"\"" withString:@" " options:NSLiteralSearch range:NSMakeRange(0,[activityText length])];
    activityLabel.text = activityText;
		
	NSString *prettyDate = [theActivity.occuredAt prettyDate];
	statusLabel.text = [NSString stringWithFormat:@"%@", prettyDate];
    storyLabel.text = theActivity.story;
}


@end