#import "ActivityItemCell.h"
#import "NSDate+Nibware.h"

@implementation ActivityItemCell



@synthesize activityLabel, statusLabel, activity, typeImage;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        
        typeImage = [[UIImageView alloc] initWithFrame:CGRectMake(4.0f, 12.0f, 20.0f, 20.0f)];
        typeImage.backgroundColor = [UIColor clearColor];
		typeImage.image = [UIImage  imageNamed:@"77-ekg.png"];
        
		activityLabel = [[UILabel alloc] initWithFrame:CGRectMake(30.0f, 3.0f, (self.contentView.frame.size.width - 55.0f) , 25.0f)];
		activityLabel.autoresizingMask = UIViewAutoresizingNone;
		activityLabel.backgroundColor = [UIColor clearColor];
		activityLabel.highlightedTextColor = [UIColor whiteColor];
		activityLabel.font = [UIFont  systemFontOfSize:14.0f];
		activityLabel.textColor = [UIColor blackColor];
		activityLabel.textAlignment = UITextAlignmentLeft;
        
		
		statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(30.0f, 23.0f, (self.contentView.frame.size.width - 55.0f) , 15.0f)];
		statusLabel.autoresizingMask = UIViewAutoresizingNone;
		statusLabel.backgroundColor = [UIColor clearColor];
		statusLabel.highlightedTextColor = [UIColor whiteColor];
		statusLabel.font = [UIFont  systemFontOfSize:11.0f];
		statusLabel.textColor = [UIColor blackColor];
		statusLabel.textAlignment = UITextAlignmentLeft;
		
		
		
		UIView* backgroundView = [ [ [ UIView alloc ] initWithFrame:CGRectZero ] autorelease ];
		self.backgroundView = backgroundView;
		
		[self.contentView addSubview:typeImage];
		[self.contentView addSubview:activityLabel];        
		[self.contentView addSubview:statusLabel];                
		
		
	}
	return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
	[super setSelected:selected animated:animated];
    
	// Configure the view for the selected state
}


- (void)setActivity:(PivotalActivity *)theActivity {
	
    
	activityLabel.text = theActivity.description;
	
	
	NSString *prettyDate = [theActivity.when prettyDate];
	
	statusLabel.text = [NSString stringWithFormat:@"%@ by %@", prettyDate, theActivity.author];
	
//	UIColor *theColor;
//	
//	if ( [theStory.currentState hasPrefix:@"accepted"] ) {
//		theColor = [UIColor colorWithRed:216.0/255.0 green:238.0/255.0 blue:206.0/255.0 alpha:1.0];
//	} else if ( [theStory.currentState hasPrefix:@"started"] || [theStory.currentState hasPrefix:@"delivered"] ) {
//		theColor = [UIColor colorWithRed:255.0/255.0 green:248.0/255.0 blue:228.0/255.0 alpha:1.0];
//	} else if ( [theStory.currentState hasPrefix:@"unstarted"] && [theStory.storyType hasPrefix:@"release"] ) {
//		theColor = [UIColor colorWithRed:64.0/255.0 green:122.0/255.0 blue:165.0/255.0 alpha:1.0];        
//	} else if ( [theStory.currentState hasPrefix:@"unscheduled"] ) {
//		theColor = [UIColor colorWithRed:231.0/255.0 green:243.0/255.0 blue:250.0/255.0 alpha:1.0];        
//		
//	} else {
//		theColor = [UIColor whiteColor];
//	}
	
	
//	[self.backgroundView setBackgroundColor:theColor];
}


- (void)dealloc {
	[activityLabel release];
	[statusLabel release];    
	[super dealloc];
}


@end