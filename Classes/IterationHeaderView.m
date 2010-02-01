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

#import "IterationHeaderView.h"


@implementation IterationHeaderView

@synthesize titleLabel,dateLabel;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
          
        [self setBackgroundColor: [UIColor colorWithRed:76.0/255.0 green:76.0/255.0 blue:76.0/255.0 alpha:1.0]];
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 1, self.bounds.size.width, 20)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:14];
        titleLabel.textColor = [UIColor whiteColor];    
        
        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 22, self.bounds.size.width, 10)];
        dateLabel.backgroundColor = [UIColor clearColor];
        dateLabel.font = [UIFont boldSystemFontOfSize:11];
        dateLabel.textColor = [UIColor whiteColor];
        dateLabel.text = kLabelNoDatesForIteration;
        
        [self addSubview:titleLabel];
        [self addSubview:dateLabel];
        
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}



- (void)setIteration:(PivotalIteration*)iteration {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = kDateFormatItertion;
    titleLabel.text = [NSString stringWithFormat:kFormatIterationNumber, iteration.iterationId];  
    if ( iteration.startDate && iteration.endDate ) {
       dateLabel.text = [NSString stringWithFormat:kLabelDateRange, [dateFormatter stringFromDate:iteration.startDate], [dateFormatter stringFromDate:iteration.endDate]];
    }
    [dateFormatter release];        

}


- (void)dealloc {
    [titleLabel release];
    [dateLabel release];
    [super dealloc];
}


@end

