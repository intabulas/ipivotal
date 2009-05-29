#import <Foundation/Foundation.h>

@interface PivotalResourceParserDelegate : NSObject {
	NSMutableArray *resources;
	NSMutableString *currentElementValue;
@private
	id target;
	SEL selector;
	NSError *error;
}

- (id)initWithTarget:(id)theTarget andSelector:(SEL)theSelector;

- (NSString *)flattenHTML:(NSString *)html;

@end
