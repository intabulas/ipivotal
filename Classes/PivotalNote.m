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

#import "PivotalNote.h"
#import "ASIHTTPRequest.h"
#import "PivotalStory.h"
#import "PivotalProject.h"
#import "PivotalNoteParserDelegate.h"

@interface PivotalNote ()
- (void)sendCommentDataToURL:(NSURL *)theURL;
- (void)receiveCommentData:(id)theResult;
@end


@implementation PivotalNote
@synthesize noteId, text, author, createdAt, visualHeight;

-(id)initWithProject:(PivotalProject *)theProject andStory:(PivotalStory *)theStory {
    [super init];
    project = theProject;
    story = theStory;
    return self;
}



-(void)dealloc {
    [text release]; text = nil;
    [author release]; author = nil;
    [createdAt release]; createdAt = nil;
    [super dealloc];
}


- (NSString *)to_xml {
   return [NSString stringWithFormat:kXmlAddComment, text];            
}



- (void)receiveCommentData:(id)theResult {
}

- (void)saveNote{
	if (self.isSaving) return;
	NSString *saveURLString = [NSString stringWithFormat:kUrlAddComment,project.projectId, story.storyId];
	NSURL *saveURL = [NSURL URLWithString:saveURLString];
	self.error = nil;
	self.savingStatus = PivotalResourceStatusSaving;
	[self performSelectorInBackground:@selector(sendCommentDataToURL:) withObject:saveURL];
}


- (void)sendCommentDataToURL:(NSURL *)theURL {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	ASIHTTPRequest *request = [PivotalResource authenticatedRequestForURL:theURL];
#if LOG_NETWORK	
    PTLog(@"URL: '%@'", theURL);
#endif
    
    NSString *newcomment = [self to_xml];
    [request addRequestHeader:kHttpContentType value:kHttpMimeTypeXml];
    [request setPostBody:[[[NSMutableData alloc] initWithData:[newcomment dataUsingEncoding:NSUTF8StringEncoding]] autorelease]];
	[request startSynchronous];
#if LOG_NETWORK	
    PTLog(@"%@", [request responseString]);
#endif    
    
   	PivotalNoteParserDelegate *parserDelegate = [[PivotalNoteParserDelegate alloc] initWithTarget:self andSelector:@selector(loadedNote:)];
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:[request responseData]];
	[parser setDelegate:parserDelegate];
	[parser setShouldProcessNamespaces:NO];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];
	[parser parse];
	[parser release];
	[parserDelegate release]; 
    
    self.savingStatus = PivotalResourceStatusSaved;
    
	[pool release];
}

- (void)loadedNote:(id)theResult {
	if ([theResult isKindOfClass:[NSError class]]) {
		self.error = theResult;
		self.status = PivotalResourceStatusNotLoaded;
	} else {
		//self. = theResult;
        NSArray *notes = theResult;
        PivotalNote *tmpNote = [notes objectAtIndex:0];
        
        self.noteId = tmpNote.noteId;
        self.text = tmpNote.text;
        self.author = tmpNote.author;
        self.createdAt = tmpNote.createdAt;
        
		self.status = PivotalResourceStatusLoaded;
	}
}
@end
