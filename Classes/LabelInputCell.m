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

#import "LabelInputCell.h"

@implementation LabelInputCell

@synthesize cellLabel, cellValue;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        
        
        cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, self.contentView.frame.size.width - 50.0f, self.contentView.frame.size.height)];
		cellLabel.autoresizingMask = UIViewAutoresizingNone;
		cellLabel.backgroundColor = [UIColor clearColor];
		cellLabel.highlightedTextColor = [UIColor whiteColor];
		cellLabel.font = [UIFont  fontWithName:@"Helvetica-Bold" size:14.0f];
		cellLabel.textColor = [UIColor blackColor];
		cellLabel.textAlignment = UITextAlignmentLeft;
        
        [self.contentView addSubview:cellLabel];

        cellValue = [[UILabel alloc] initWithFrame:CGRectMake(65.0f, 0.0f, self.contentView.frame.size.width - 50.0f, self.contentView.frame.size.height)];
		cellValue.autoresizingMask = UIViewAutoresizingNone;
		cellValue.backgroundColor = [UIColor clearColor];
		cellValue.highlightedTextColor = [UIColor whiteColor];
		cellValue.font = [UIFont  fontWithName:@"Helvetica"  size:14.0f];
		cellValue.textColor = [UIColor blackColor];
		cellValue.textAlignment = UITextAlignmentLeft;
        
        [self.contentView addSubview:cellValue];
        
    }
    return self;
}


- (void) setFrame:(CGRect)theFrame {
    [super setFrame:theFrame];
}    


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}

- (void)setValue:(NSString*)value {
	cellValue.text = value;
}

- (void)setText:(NSString*)text {
	cellLabel.text = text;
}

- (NSString*)text {
	return cellLabel.text;
}


- (void)dealloc {
    [cellLabel release]; cellLabel = nil;
    [cellValue release]; cellValue = nil;
    [super dealloc];
}


@end
