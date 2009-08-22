#import "PivotalNoteParserDelegate.h"
#import "PivotalNote.h"


@implementation PivotalNoteParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	[super parserDidStartDocument:parser];
	dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateFormat = kDateFormatUTC;
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    if  ([elementName isEqualToString:kTagNote]) {
        currentNote = [[PivotalNote alloc] initWithProject:nil andStory:nil];
	}    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:kTagNote]) {
        [resources addObject:currentNote];
        [currentNote release];
        currentNote = nil;        
	} else if ([elementName isEqualToString:kTagId]) {             
        currentNote.noteId = [currentElementValue integerValue];
	} else if ([elementName isEqualToString:kTagText]) {          
        currentNote.text = currentElementValue;
	} else if ([elementName isEqualToString:kTagAuthor]) {          
        currentNote.author = currentElementValue;
	} else if ([elementName isEqualToString:kTagNotedAt]) {          
        currentNote.createdAt =  [dateFormatter dateFromString:currentElementValue];       
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
    [currentNote release];
	[dateFormatter release];
    [super dealloc];
}

@end


