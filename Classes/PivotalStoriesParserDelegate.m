#import "PivotalStoriesParserDelegate.h"
#import "PivotalStory.h"


@implementation PivotalStoriesParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	[super parserDidStartDocument:parser];
	dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateFormat = @"yyyy/MM/dd HH:mm:ss 'UTC'";
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:@"story"]) {
        currentStory = [[PivotalStory alloc] init];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"story"]) {
        [resources addObject:currentStory];
        [currentStory release];
        currentStory = nil;        
	} else if ([elementName isEqualToString:@"id"]) {      
        currentStory.storyId = [currentElementValue integerValue];
	} else if ([elementName isEqualToString:@"story_type"]) {              
        currentStory.storyType = currentElementValue;
	} else if ([elementName isEqualToString:@"url"]) {              
        currentStory.url = [NSURL URLWithString:currentElementValue];
	} else if ([elementName isEqualToString:@"estimate"]) {                      
        currentStory.estimate = [currentElementValue integerValue];
	} else if ([elementName isEqualToString:@"current_state"]) {                      
        currentStory.currentState = currentElementValue;
	} else if ([elementName isEqualToString:@"description"]) {
        currentStory.description = currentElementValue;
	} else if ([elementName isEqualToString:@"name"]) {
        currentStory.name = currentElementValue;
	} else if ([elementName isEqualToString:@"requested_by"]) {
        currentStory.requestedBy = currentElementValue;
   	} else if ([elementName isEqualToString:@"owned_by"]) {         
        currentStory.owner = currentElementValue;
	} else if ([elementName isEqualToString:@"created_at"]) {  
        currentStory.createdAt = [dateFormatter dateFromString:currentElementValue];
	} else if ([elementName isEqualToString:@"accepted_at"]) {  
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


