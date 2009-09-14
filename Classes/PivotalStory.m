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

#import "PivotalStory.h"
#import "PivotalProject.h"

@implementation PivotalStory

@synthesize storyId, storyType, estimate, url, currentState, description, name, requestedBy, owner, createdAt, acceptedAt, comments, tasks;

#pragma mark -
#pragma mark Cleanup Methods

- (id)init {
    [super init];
    storyType = kTypeFeature;
    estimate = 0;
    name = kTextStoryNeedsName;
    description = kTextStoryDescription;
    comments = [[NSMutableArray alloc] init];
    tasks = [[NSMutableArray alloc] init];
    return self;
}

- (id)initWithStoryId:(NSInteger)theId {
    [self init];
    storyId = theId;
    return self;
}

//- (NSString *)description {
//    return [NSString stringWithFormat:@"<PivotalStory name:'%@' comments:'%d' tasks:'%d'>", name, [comments count], [tasks count]];
//}

- (id)initWithStoryId:(NSInteger)theId andProject:(PivotalProject *)theProject {
  [self initWithStoryId:theId];
    project = [theProject retain];
  return self;
}

- (void)dealloc {
    if ( project != nil )  {
        [project release];
    }
    [comments release]; comments = nil;
    [tasks release]; tasks = nil;
    [storyType release];
    [url release];
    [currentState release];
    [description release];
    [name release];
    [requestedBy release];
    [owner release];
    [createdAt release];
    [acceptedAt release];    
    [super dealloc];
}

- (NSString *)to_xml {
    if ([storyType hasPrefix:kTypeFeature]) {
        return [NSString stringWithFormat:kXmlAddStoryFeature, [storyType lowercaseString], name, estimate];            
    } else {
        return [NSString stringWithFormat:kXmlAddStory, [storyType lowercaseString], name];    
    }
}


- (void)loadStory {
	if (self.isSaving) return;
	NSString *saveURLString = [NSString stringWithFormat:kUrlUpdateStory,project.projectId, self.storyId];
	NSURL *saveURL = [NSURL URLWithString:saveURLString];
	self.error = nil;
	self.savingStatus = PivotalResourceStatusSaving;
	[self performSelectorInBackground:@selector(retrieveContentFromURL:) withObject:saveURL];
}


- (void)retrieveContentFromURL:(NSURL *)theURL {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	ASIHTTPRequest *request = [PivotalResource authenticatedRequestForURL:theURL];
    [request setRequestMethod:@"GET"];    
    [request addRequestHeader:kHttpContentType value:kHttpMimeTypeXml];
	[request start];
#ifdef LOG_NETWORK	
    NSLog(@"%@", [request responseString]);
#endif    
    self.savingStatus = PivotalResourceStatusSaved;
    
	[pool release];
}



@end
