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

#import "ActivityLabelCell.h"

@implementation ActivityLabelCell

@synthesize cellLabel, activityView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setAccessoryType:UITableViewCellAccessoryNone];        
        
        cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(34.0f, 0.0f, (self.contentView.frame.size.width - 26.0f), self.contentView.frame.size.height)];
        cellLabel.autoresizingMask = UIViewAutoresizingNone;
        cellLabel.backgroundColor = [UIColor clearColor];
        cellLabel.highlightedTextColor = [UIColor whiteColor];
        cellLabel.font = [UIFont  fontWithName:@"Helvetica" size:17.0f];
        cellLabel.textColor = [UIColor blackColor];
        cellLabel.textAlignment = UITextAlignmentLeft;
        [cellLabel setText:kLabelLoadingProgress];
    
        activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(6.0f, 13.0f, 20.0f, 20.0f)];
        activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        activityView.hidesWhenStopped = YES;
        
        [self.contentView addSubview:activityView]; 
        [self.contentView addSubview:cellLabel];
    
    }
    return self;
}

- (void) setFrame:(CGRect)theFrame {
    [super setFrame:theFrame];
}    


- (void)dealloc {
    [cellLabel release]; cellLabel = nil;
    [activityView release]; activityView = nil;
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];
}



@end

