//
//  GroupCell.m
//  iPivotal
//
//  Created by Mark Lussier on 5/29/09.
//  Copyright 2009 Juniper Networks. All rights reserved.
//

#import "GroupCell.h"


@implementation GroupCell

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [icon release];
    [label release];
    [super dealloc];
}


@end
