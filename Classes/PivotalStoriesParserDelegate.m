#import "PivotalStoriesParserDelegate.h"
#import "PivotalStory.h"
#import "PivotalNote.h"
#import "PivotalTask.h"


@implementation PivotalStoriesParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	[super parserDidStartDocument:parser];
	dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateFormat = kDateFormatUTC;
    handlingNotes = NO;
    handlingTasks = NO;
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:kTagStory]) {
        currentStory = [[PivotalStory alloc] init];
	} else if ([elementName isEqualToString:kTagNote]) {
        currentNote = [[PivotalNote alloc] initWithProject:nil andStory:nil];
        handlingNotes = YES;
	} else if ([elementName isEqualToString:kTagTask]) {
        currentTask = [[PivotalTask alloc] initWithProject:nil andStory:nil];
        handlingTasks = YES;
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
        
        handlingNotes = NO;                
	} else if ([elementName isEqualToString:kTagId]) {             
        if ( handlingNotes ) { 
            currentNote.noteId = [currentElementValue integerValue];
        } if ( handlingTasks ) {
            currentTask.taskId  = [currentElementValue integerValue];
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
	} else if ([elementName isEqualToString:kTagDescription]) {
        if ( handlingTasks ) {        
            currentTask.description = currentElementValue;
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
        currentTask.complete = [currentElementValue integerValue];
        
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
    [currentStory release];
	[dateFormatter release];
    [super dealloc];
}

@end


