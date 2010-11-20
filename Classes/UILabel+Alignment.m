//
//  UILabel+Alignment.m
//  Gracious
//
//  Created by Mark Lussier on 9/8/10.
//  Copyright 2010 Mark Lussier. All rights reserved.
//

#import "UILabel+Alignment.h"


@implementation UILabel (Alignment) 

- (void)alignTop {
    CGSize fontSize = [self.text sizeWithFont:self.font];
    
    double finalHeight = fontSize.height * self.numberOfLines;
    double finalWidth = self.frame.size.width;    //expected width of label
    
    
    CGSize theStringSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    
    
    int newLinesToPad = (finalHeight  - theStringSize.height) / fontSize.height;
    if ( newLinesToPad > 0 ) { self.text = [self.text stringByAppendingString:@" "]; }
    for(int i=1; i< newLinesToPad; i++) {
        self.text = [self.text stringByAppendingString:@"\n"];
    }
}

- (void)alignBottom {
    CGSize fontSize = [self.text sizeWithFont:self.font];
    
    double finalHeight = fontSize.height * self.numberOfLines;
    double finalWidth = self.frame.size.width;    //expected width of label
    
    
    CGSize theStringSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    
    
    int newLinesToPad = (finalHeight  - theStringSize.height) / fontSize.height;
    
    for(int i=1; i< newLinesToPad; i++) {
        self.text = [NSString stringWithFormat:@" \n%@",self.text];
    }
}

@end
