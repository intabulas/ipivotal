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

#import "PivotalProjects.h"
#import "PivotalProjectsParserDelegate.h"

@interface PivotalProjects ()
- (void)fetchProjects;
@end

@implementation PivotalProjects

@synthesize url, projects;

- (id)init {
    [super init];
    self.url = [NSURL URLWithString:kUrlProjectList];
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<PivotalProjects url:'%@'>", url];
}

#pragma mark -
#pragma mark Loading methods

- (void)loadProjects {
    self.error = nil;
    self.status = PivotalResourceStatusLoading;
    [self performSelectorInBackground:@selector(loadRecords) withObject:nil];
}



- (void)loadedProjects:(id)theResult {
    if ( [theResult isKindOfClass:[NSError class]]) {
        self.error = theResult;
        self.status = PivotalResourceStatusNotLoaded;
    } else {
        self.projects = theResult;
        self.status = PivotalResourceStatusLoaded;
    }
}

- (void)loadRecords {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];    
        self.fetchProjects;
    [pool release];    
}


- (void)reloadProjects {
	if (self.isLoading) return;
	self.error = nil;
	self.status = PivotalResourceStatusLoading;
	[self performSelectorInBackground:@selector(fetchProjects) withObject:nil];    
}


- (void)fetchProjects {

	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;    
    ASIHTTPRequest *request = [PivotalResource authenticatedRequestForURL:self.url];
	[request startSynchronous];
    self.error = [request error];
	PivotalProjectsParserDelegate *parserDelegate = [[PivotalProjectsParserDelegate alloc] initWithTarget:self andSelector:@selector(loadedProjects:)];
#ifdef LOG_NETWORK    
    NSLog(@" Response: '%@'", [request responseString]);
#endif
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:[request responseData]];
	[parser setDelegate:parserDelegate];
	[parser setShouldProcessNamespaces:NO];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];
	[parser parse];
	[parser release];
	[parserDelegate release];
    
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;		
	[pool release];    
}




#pragma mark === Cleanup ===

- (void)dealloc {
    [url release];
    [projects release];
    [super dealloc];
}

@end
