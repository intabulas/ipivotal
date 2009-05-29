//
//  PivotalProject.m
//  iPivotal
//
//  Created by Mark Lussier on 5/28/09.
//  Copyright 2009 Juniper Networks. All rights reserved.
//

#import "PivotalProject.h"


@implementation PivotalProject

@synthesize projectId, name, iterationLength, weekStartDay, pointScale;

#pragma mark 0
#pragma mark Cleanup Methods

- (void)dealloc {
    [name release];
    [weekStartDay release];
    [pointScale release];
    [super dealloc];
}
@end
