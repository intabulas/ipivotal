#import "PivotalStoriesParserDelegate.h"
#import "PivotalStory.h"


@implementation PivotalStoriesParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	[super parserDidStartDocument:parser];
	dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateFormat = kDateFormatUTC;
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:kTagStory]) {
        currentStory = [[PivotalStory alloc] init];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:kTagStory]) {
        [resources addObject:currentStory];
        [currentStory release];
        currentStory = nil;        
	} else if ([elementName isEqualToString:kTagId]) {      
        currentStory.storyId = [currentElementValue integerValue];
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


