#import "PivotalActivityParserDelegate.h"
#import "PivotalActivity.h"

@implementation PivotalActivityParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	[super parserDidStartDocument:parser];
	dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateFormat = @"MM/dd/yyyy hh:mm a";
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:@"activity"]) {
        currentActivity = [[PivotalActivity alloc] init];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"activity"]) {
        [resources addObject:currentActivity];
        [currentActivity release];
        currentActivity = nil;        
	} else if ([elementName isEqualToString:@"id"]) {      
        currentActivity.activityId = [currentElementValue integerValue];
	} else if ([elementName isEqualToString:@"project"]) {              
        currentActivity.project = currentElementValue;
	} else if ([elementName isEqualToString:@"story"]) {              
        currentActivity.story = currentElementValue;
	} else if ([elementName isEqualToString:@"description"]) {                      
        currentActivity.description = currentElementValue;
	} else if ([elementName isEqualToString:@"author"]) {                      
        currentActivity.author = currentElementValue;
	} else if ([elementName isEqualToString:@"when"]) {  
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


