#import "PivotalActivityParserDelegate.h"
#import "PivotalActivity.h"

@implementation PivotalActivityParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	[super parserDidStartDocument:parser];
	dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateFormat = kDateFormatActivity;
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
	} else if ([elementName isEqualToString:kTagProject]) {              
        currentActivity.project = currentElementValue;
	} else if ([elementName isEqualToString:kTagStory]) {              
        currentActivity.story = currentElementValue;
	} else if ([elementName isEqualToString:kTagDescription]) {                      
        currentActivity.description = currentElementValue;
	} else if ([elementName isEqualToString:kTagAuthor]) {                      
        currentActivity.author = currentElementValue;
	} else if ([elementName isEqualToString:kTagWhen]) {  
        currentActivity.when = [dateFormatter dateFromString:currentElementValue];
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
    [currentActivity release];
	[dateFormatter release];
    [super dealloc];
}

@end


