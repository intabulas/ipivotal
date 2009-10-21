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

#import "PivotalProjectsParserDelegate.h"
#import "PivotalProject.h"


@implementation PivotalProjectsParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	[super parserDidStartDocument:parser];
    handlingMembership = NO;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	if ([elementName isEqualToString:kTagProject]) {
		currentProject = [[PivotalProject alloc] init];
    } else if ([elementName isEqualToString:kTagMembership]) {
        handlingMembership = YES;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:kTagProject]) {
		[resources addObject:currentProject];
		[currentProject release];
		currentProject = nil;
        handlingMembership = NO;
	} else if ([elementName isEqualToString:kTagId]) {  
        if (handlingMembership ) {
        } else {
        currentProject.projectId = [currentElementValue integerValue];
        }
	} else if ([elementName isEqualToString:kTagIterationLength]) {      
        currentProject.iterationLength = [currentElementValue integerValue];
	} else if ([elementName isEqualToString:kTagName]) {        
        if (handlingMembership ) {
        } else {        
          currentProject.name  = currentElementValue;        
        }
	} else if ([elementName isEqualToString:kTagWeekStartDay]) {        
        currentProject.weekStartDay  = currentElementValue;        
	} else if ([elementName isEqualToString:kTagpPointScale]) {        
        currentProject.pointScale  = currentElementValue;        
	} 

	[currentElementValue release];
	currentElementValue = nil;
}


- (void)parserDidEndDocument:(NSXMLParser *)parser {
	[super parserDidEndDocument:parser];
}

#pragma mark -
#pragma mark Cleanup

- (void)dealloc {
	[currentProject release];
    [super dealloc];
}

@end


