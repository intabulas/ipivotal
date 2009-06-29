#import "PivotalProjectsParserDelegate.h"
#import "PivotalProject.h"


@implementation PivotalProjectsParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	[super parserDidStartDocument:parser];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	if ([elementName isEqualToString:@"project"]) {
		currentProject = [[PivotalProject alloc] init];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:@"project"]) {
		[resources addObject:currentProject];
		[currentProject release];
		currentProject = nil;
	} else if ([elementName isEqualToString:@"id"]) {      
        currentProject.projectId = [currentElementValue integerValue];
	} else if ([elementName isEqualToString:@"iteration_length"]) {      
        currentProject.iterationLength = [currentElementValue integerValue];
	} else if ([elementName isEqualToString:@"name"]) {        
        currentProject.name  = currentElementValue;        
	} else if ([elementName isEqualToString:@"week_start_day"]) {        
        currentProject.weekStartDay  = currentElementValue;        
	} else if ([elementName isEqualToString:@"point_scale"]) {        
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


