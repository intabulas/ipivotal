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

#import "PivotalProject.h"
#import "PivotalMembership.h"

@implementation PivotalProject

@synthesize projectId, name, iterationLength, weekStartDay, pointScale, velocityScheme, initialVelocity, currentVelocity, numberDoneIterations, allowsAttachments,
            publicProject, useHttps, estimateBugsAndChores, commitMode, members, integrations, labels, lastActivityAt;

- (id)init {
	[super init];
	self.allowsAttachments = FALSE;
	self.publicProject = FALSE;
	self.useHttps = FALSE;
	self.estimateBugsAndChores = FALSE;
	self.commitMode = FALSE;
	members = [[NSMutableArray alloc] init];
	integrations  = [[NSMutableArray alloc] init];
	labels  = [[NSMutableArray alloc] init];

	
    return self;
}

#pragma mark -
#pragma mark Cleanup Methods

- (void)dealloc {
    [name release]; name = nil;
    [weekStartDay release]; weekStartDay = nil;
    [pointScale release]; pointScale = nil;
	[velocityScheme release]; velocityScheme = nil;
	[members release]; members = nil;
	[integrations release]; integrations = nil;
	[lastActivityAt release]; lastActivityAt = nil;
    [labels release]; labels = nil;
    [super dealloc];
}


#pragma mark 
#pragma mark === Find Member By Id ===
#pragma mark 

- (PivotalMembership*) memberForId:(NSInteger)memberId {
    PivotalMembership *foundMember;
    
    for (PivotalMembership *themember in self.members) {
        if ( themember.membershipId == memberId ) {
           foundMember = themember;
            break;
        }
    }    
    return foundMember;    
    
}


@end

