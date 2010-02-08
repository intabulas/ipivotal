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


#import "PivotalIterationsParserDelegate.h"
#import "PivotalIteration.h"
#import "PivotalNote.h"
#import "PivotalStory.h"


@implementation PivotalIterationsParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	[super parserDidStartDocument:parser];
	dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateFormat = kDateFormatUTC;
    handlingStory = NO;
    handlingNotes = NO;
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	if ([elementName isEqualToString:kTagIteration]) {
		currentIteration = [[PivotalIteration alloc] init];
    } else if ([elementName isEqualToString:kTagStory]) {
        currentStory = [[PivotalStory alloc] init];
        handlingStory= YES;
    } else if ([elementName isEqualToString:kTagNote]) {
        currentNote = [[PivotalNote alloc] initWithProject:nil andStory:nil];
        handlingNotes = YES;
        
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:kTagIteration]) {
		[resources addObject:currentIteration];
		[currentIteration release];
		currentIteration = nil;
    } else if ([elementName isEqualToString:kTagStory]) {
        [currentIteration.stories addObject:currentStory];
        [currentStory release];
        currentStory = nil;        
        handlingStory = NO;
    } else if ([elementName isEqualToString:kTagNote]) {
        [currentStory.comments addObject:currentNote];
        [currentNote release];
        currentNote = nil;        
        handlingNotes = NO;                
	} else if ([elementName isEqualToString:kTagId]) {      
        if ( handlingStory && !handlingNotes ) { 
            currentStory.storyId = [currentElementValue integerValue];
        } else if ( handlingNotes ) { 
                currentNote.noteId = [currentElementValue integerValue];            
        } else {
           currentIteration.iterationId = [currentElementValue integerValue];
        }
	} else if ([elementName isEqualToString:kTagNumber]) {      
        currentIteration.iterationNumber = [currentElementValue integerValue];
	} else if ([elementName isEqualToString:kTagStart]) {             
        currentIteration.startDate = [dateFormatter dateFromString:currentElementValue];
	} else if ([elementName isEqualToString:kTagFinish]) {                      
        currentIteration.endDate = [dateFormatter dateFromString:currentElementValue];        
        
	} else if ([elementName isEqualToString:kTagStoryType]) {              
        currentStory.storyType = currentElementValue;
	} else if ([elementName isEqualToString:kTagUrl]) {              
        currentStory.url = [NSURL URLWithString:currentElementValue];
	} else if ([elementName isEqualToString:kTagEstimate]) {                      
        currentStory.estimate = [currentElementValue integerValue];
	} else if ([elementName isEqualToString:kTagCurrentState]) {                      
        currentStory.currentState = currentElementValue;
	} else if ([elementName isEqualToString:kTagDescription]) {
        currentStory.description = currentElementValue;
	} else if ([elementName isEqualToString:kTagName]) {
        currentStory.name = currentElementValue;
	} else if ([elementName isEqualToString:kTagRequestedBy]) {
        currentStory.requestedBy = currentElementValue;
   	} else if ([elementName isEqualToString:kTagOwnedBy]) {         
        currentStory.owner = currentElementValue;
	} else if ([elementName isEqualToString:kTagCreatedAt]) {  
        currentStory.createdAt = [dateFormatter dateFromString:currentElementValue];
	} else if ([elementName isEqualToString:kTagAcceptedAt]) {  
        currentStory.acceptedAt = [dateFormatter dateFromString:currentElementValue];        
    } else if ([elementName isEqualToString:kTagText]) {          
        currentNote.text = currentElementValue;
	} else if ([elementName isEqualToString:kTagLabels]) {      
        currentStory.labels =  [NSMutableArray arrayWithArray:[currentElementValue componentsSeparatedByString:kComma]];   
	} else if ([elementName isEqualToString:kTagAuthor]) {          
        currentNote.author = currentElementValue;
	} else if ([elementName isEqualToString:kTagNotedAt]) {          
        currentNote.createdAt =  [dateFormatter dateFromString:currentElementValue];         
	} else if ([elementName isEqualToString:kTagUpdatedAt]) {  
        currentStory.updatedAt = [dateFormatter dateFromString:currentElementValue];
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
	[currentIteration release];
    [currentStory release];
	[dateFormatter release];
    [super dealloc];
}

@end


