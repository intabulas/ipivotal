//
//	Copyright (c) 2008-2009, Mark Lussier
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

#import "CommentHeaderView.h"
#import "NSDate+Nibware.h"

@implementation CommentHeaderView

@synthesize commentImage, commentTitle;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        
       // [self setBackgroundColor: [UIColor colorWithRed:154.0/255.0 green:154.0/255.0 blue:154.0/255.0 alpha:1.0]];
//        [self setBackgroundColor: [UIColor colorWithRed:76.0/255.0 green:76.0/255.0 blue:76.0/255.0 alpha:1.0]];
        [self setBackgroundColor:[UIColor grayColor]];
        
        commentImage = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 26.0f, 22.0f)];
        commentImage.backgroundColor = [UIColor clearColor];
        commentImage.contentMode = UIViewContentModeCenter;
        commentImage.image = [UIImage imageNamed:kIconCommentSmall];
        
        commentTitle = [[UILabel alloc] initWithFrame:CGRectMake(30.0f, -15.0f, (self.frame.size.width - 30.0f) , self.frame.size.height)];
		commentTitle.autoresizingMask = UIViewAutoresizingNone;
		commentTitle.backgroundColor = [UIColor clearColor];
		commentTitle.highlightedTextColor = [UIColor whiteColor];
		commentTitle.font = [UIFont  systemFontOfSize:12.0f];
		commentTitle.textColor = [UIColor whiteColor];
		commentTitle.textAlignment = UITextAlignmentLeft;
        
        [self addSubview:commentImage];
        [self addSubview:commentTitle];
        
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}



- (void)setNote:(PivotalNote *)note {
    commentTitle.text = [NSString stringWithFormat:kLabelCommentHeader, note.author, [note.createdAt prettyDate] ];
}


- (void)dealloc {
    [commentTitle release];
    [commentImage release];
    [super dealloc];
}


@end

