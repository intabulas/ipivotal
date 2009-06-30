#import "ActivityItemCell.h"
#import "NSDate+Nibware.h"

@implementation ActivityItemCell



@synthesize activityLabel, statusLabel, activity, typeImage, storyLabel;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        
        typeImage = [[UIImageView alloc] initWithFrame:CGRectMake(4.0f, 20.0f, 20.0f, 20.0f)];
        typeImage.backgroundColor = [UIColor clearColor];
		typeImage.image = [UIImage  imageNamed:@"77-ekg.png"];

		storyLabel = [[UILabel alloc] initWithFrame:CGRectMake(30.0f, 18.0f, (self.contentView.frame.size.width - 55.0f) , 25.0f)];
		storyLabel.autoresizingMask = UIViewAutoresizingNone;
		storyLabel.backgroundColor = [UIColor clearColor];
		storyLabel.highlightedTextColor = [UIColor whiteColor];
		storyLabel.font = [UIFont  systemFontOfSize:12.0f];
		storyLabel.textColor = [UIColor blackColor];
		storyLabel.textAlignment = UITextAlignmentLeft;
        
        
        
		activityLabel = [[UILabel alloc] initWithFrame:CGRectMake(30.0f, 2.0f, (self.contentView.frame.size.width - 55.0f) , 25.0f)];
		activityLabel.autoresizingMask = UIViewAutoresizingNone;
		activityLabel.backgroundColor = [UIColor clearColor];
		activityLabel.highlightedTextColor = [UIColor whiteColor];
		activityLabel.font = [UIFont  systemFontOfSize:12.0f];
		activityLabel.textColor = [UIColor blackColor];
		activityLabel.textAlignment = UITextAlignmentLeft;
        
		
		statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(30.0f, 38.0f, (self.contentView.frame.size.width - 55.0f) , 15.0f)];
		statusLabel.autoresizingMask = UIViewAutoresizingNone;
		statusLabel.backgroundColor = [UIColor clearColor];
		statusLabel.highlightedTextColor = [UIColor whiteColor];
		statusLabel.font = [UIFont  systemFontOfSize:10.0f];
		statusLabel.textColor = [UIColor blackColor];
		statusLabel.textAlignment = UITextAlignmentLeft;
		
		
		
		UIView* backgroundView = [ [ [ UIView alloc ] initWithFrame:CGRectZero ] autorelease ];
		self.backgroundView = backgroundView;
		
		[self.contentView addSubview:typeImage];
        [self.contentView addSubview:storyLabel];
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
	

    NSMutableString *activityText = [[NSMutableString alloc] initWithString:theActivity.description];
    [activityText replaceOccurrencesOfString:@"\"" withString:@" " options:NSLiteralSearch range:NSMakeRange(0,[activityText length])];
     activityLabel.text = activityText;
	
	
	NSString *prettyDate = [theActivity.when prettyDate];
	

    
	statusLabel.text = [NSString stringWithFormat:@"%@ / %@", prettyDate, theActivity.project];
	
    storyLabel.text = theActivity.story;
    
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
    [storyLabel release];
	[statusLabel release];    
	[super dealloc];
}


@end