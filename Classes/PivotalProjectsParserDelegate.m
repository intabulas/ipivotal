#import "PivotalProjectsParserDelegate.h"
#import "PivotalProject.h"


@implementation PivotalProjectsParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	[super parserDidStartDocument:parser];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	if ([elementName isEqualToString:kTagProject]) {
		currentProject = [[PivotalProject alloc] init];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:kTagProject]) {
		[resources addObject:currentProject];
		[currentProject release];
		currentProject = nil;
	} else if ([elementName isEqualToString:kTagId]) {      
        currentProject.projectId = [currentElementValue integerValue];
	} else if ([elementName isEqualToString:kTagIterationLength]) {      
        currentProject.iterationLength = [currentElementValue integerValue];
	} else if ([elementName isEqualToString:kTagName]) {        
        currentProject.name  = currentElementValue;        
	} else if ([elementName isEqualToString:kTagWeekStartDay]) {        
        currentProject.weekStartDay  = currentElementValue;        
	} else if ([elementName isEqualToString:kTagpPointScale]) {        
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


