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

#import "PivotalActivityParserDelegate.h"
#import "PivotalActivity.h"

@implementation PivotalActivityParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	[super parserDidStartDocument:parser];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];    
	dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateFormat = kDateFormatUTC;
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:kTagActivity]) {
        currentActivity = [[PivotalActivity alloc] init];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:kTagActivity]) {
        [resources addObject:currentActivity];
        [currentActivity release];
        currentActivity = nil;        
	} else if ([elementName isEqualToString:kTagId]) {      
        currentActivity.activityId = [currentElementValue integerValue];
	} else if ([elementName isEqualToString:kTagOccuredAt]) {  
        currentActivity.occuredAt = [dateFormatter dateFromString:currentElementValue];
	} else if ([elementName isEqualToString:kTagVersion]) {  
        currentActivity.version = [currentElementValue integerValue];
	} else if ([elementName isEqualToString:kTagEventType]) {  
        currentActivity.eventType = currentElementValue;
	} else if ([elementName isEqualToString:kTagAuthor]) {                      
        currentActivity.author = currentElementValue;
	} else if ([elementName isEqualToString:kTagProjectId]) {              
        currentActivity.projectId = [currentElementValue integerValue];
	} else if ([elementName isEqualToString:kTagName]) {              
        currentActivity.story = currentElementValue;
	} else if ([elementName isEqualToString:kTagDescription]) {                      
        currentActivity.description = currentElementValue;
	} 
    
	[currentElementValue release];
	currentElementValue = nil;
}


- (void)parserDidEndDocument:(NSXMLParser *)parser {
	[super parserDidEndDocument:parser];
	[dateFormatter release];
	dateFormatter = nil;
}

#pragma mark -
#pragma mark Cleanup

- (void)dealloc {
    [currentActivity release]; currentActivity = nil;
	[dateFormatter release]; dateFormatter = nil;
    [super dealloc];
}

@end


