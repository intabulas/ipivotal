//
//	Copyright (c) 2008-2011, Mark Lussier
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

#import "PivotalStoriesParserDelegate.h"
#import "PivotalStory.h"
#import "PivotalNote.h"
#import "PivotalTask.h"
#import "PivotalAttachment.h"


@implementation PivotalStoriesParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	[super parserDidStartDocument:parser];
	dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];    
	[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];	
	dateFormatter.dateFormat = kDateFormatUTC;
    handlingNotes = NO;
    handlingTasks = NO;
	handlingAttachments = NO;
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:kTagStory]) {
        currentStory = [[PivotalStory alloc] init];
	} else if ([elementName isEqualToString:kTagNote]) {
        currentNote = [[PivotalNote alloc] initWithProject:nil andStory:nil];
        handlingNotes = YES;
	} else if ([elementName isEqualToString:kTagNote]) {
        currentNote = [[PivotalNote alloc] initWithProject:nil andStory:nil];
        handlingNotes = YES;		
	} else if ([elementName isEqualToString:kTagTask]) {
        currentTask = [[PivotalTask alloc] initWithProject:nil andStory:nil];
        handlingTasks = YES;
	} else if ([elementName isEqualToString:kTagAttachment]) {
        currentAttachment = [[PivotalAttachment alloc] init];
        handlingAttachments = YES;
		
    }
        
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:kTagStory]) {
        [resources addObject:currentStory];
        [currentStory release];
        currentStory = nil;        
    } else if ([elementName isEqualToString:kTagNote]) {
        [currentStory.comments addObject:currentNote];
        [currentNote release];
        currentNote = nil;        
        handlingNotes = NO;        
    } else if ([elementName isEqualToString:kTagTask]) {
        [currentStory.tasks addObject:currentTask];
        [currentTask release];
        currentTask = nil;        
        
        handlingTasks = NO;                
    } else if ([elementName isEqualToString:kTagAttachment]) {
        [currentStory.attachments addObject:currentAttachment];
        [currentAttachment release];
        currentAttachment = nil;        
        
        handlingAttachments = NO;                
		
	} else if ([elementName isEqualToString:kTagId]) {             
        if ( handlingNotes ) { 
            currentNote.noteId = [currentElementValue integerValue];
        } else if ( handlingTasks ) {
            currentTask.taskId  = [currentElementValue integerValue];
        } else if ( handlingAttachments) {
            currentAttachment.attachmentId  = [currentElementValue integerValue];
        } else {
            currentStory.storyId = [currentElementValue integerValue];
        }                
	} else if ([elementName isEqualToString:kTagStoryType]) {              
        currentStory.storyType = currentElementValue;
	} else if ([elementName isEqualToString:kTagUrl]) {              
        currentStory.url = [NSURL URLWithString:currentElementValue];
	} else if ([elementName isEqualToString:kTagEstimate]) {                      
        currentStory.estimate = [currentElementValue integerValue];
	} else if ([elementName isEqualToString:kTagCurrentState]) {                      
        currentStory.currentState = currentElementValue;

	} else if ([elementName isEqualToString:kTagFilename] && handlingAttachments) {                      
        currentAttachment.filename = currentElementValue;
	} else if ([elementName isEqualToString:kTagUploadedBy] && handlingAttachments) {                      
        currentAttachment.uploadedBy = currentElementValue;
	} else if ([elementName isEqualToString:kTagUploadedAt] && handlingAttachments) {                      
        currentAttachment.uploadedAt = [dateFormatter dateFromString:currentElementValue]; 	
	
	} else if ([elementName isEqualToString:kTagDescription]) {
        if ( handlingTasks ) {        
            currentTask.description = currentElementValue;
        } else if (handlingAttachments) {  			
			currentAttachment.description = currentElementValue;
        } else {
          currentStory.description = currentElementValue;
        }
	} else if ([elementName isEqualToString:kTagName]) {
        currentStory.name = currentElementValue;
	} else if ([elementName isEqualToString:kTagRequestedBy]) {
        currentStory.requestedBy = currentElementValue;
   	} else if ([elementName isEqualToString:kTagOwnedBy]) {         
        currentStory.owner = currentElementValue;
	} else if ([elementName isEqualToString:kTagCreatedAt]) {  
        if ( handlingTasks ) {
            currentTask.createdAt = [dateFormatter dateFromString:currentElementValue];
        } else {
            currentStory.createdAt = [dateFormatter dateFromString:currentElementValue];
        }
	} else if ([elementName isEqualToString:kTagUpdatedAt]) {  
        if ( handlingTasks ) {
        } else {
            currentStory.updatedAt = [dateFormatter dateFromString:currentElementValue];
        }
	} else if ([elementName isEqualToString:kTagLabels]) {      
        currentStory.labels =  [NSMutableArray arrayWithArray:[currentElementValue componentsSeparatedByString:kComma]];   
   	} else if ([elementName isEqualToString:kTagLighthouseUrl]) {  
		currentStory.lighthouseUrl = currentElementValue;
   	} else if ([elementName isEqualToString:kTagLighthouseId]) {  
		currentStory.lighthouseId = [currentElementValue integerValue];
    } else if ([elementName isEqualToString:kTagDeadline]) {  
        currentStory.deadline = [dateFormatter dateFromString:currentElementValue];                		
	} else if ([elementName isEqualToString:kTagAcceptedAt]) {  
        currentStory.acceptedAt = [dateFormatter dateFromString:currentElementValue];        
	} else if ([elementName isEqualToString:kTagText]) {          
        currentNote.text = currentElementValue;
	} else if ([elementName isEqualToString:kTagAuthor]) {          
        currentNote.author = currentElementValue;
	} else if ([elementName isEqualToString:kTagNotedAt]) {          
        currentNote.createdAt =  [dateFormatter dateFromString:currentElementValue];       
	} else if ([elementName isEqualToString:kTagPosition]) {      
        currentTask.position = [currentElementValue integerValue];
	} else if ([elementName isEqualToString:kTagComplete]) {      
        currentTask.complete = [currentElementValue boolValue];
        
        
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
    [currentStory release]; currentStory = nil;
	[currentNote release]; currentNote = nil;
	[currentTask release]; currentTask = nil;
	[currentAttachment release]; currentAttachment = nil;
	[dateFormatter release]; dateFormatter = nil;
    [super dealloc];
}

@end


