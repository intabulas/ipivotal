//
//  LabelCell.m
//  iPivotal
//
//  Created by Mark Lussier on 5/30/09.
//  Copyright 2009 Juniper Networks. All rights reserved.
//

#import "LabelCell.h"


@implementation LabelCell

@synthesize textLabel;

- (void)dealloc {
    [textLabel dealloc];
    [super dealloc];
}


@end
