#import "IterationStoryCell.h"


@implementation IterationStoryCell

@synthesize typeImage, estimateImage, storyLabel, statusLabel, story;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
        if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        
                typeImage = [[UIImageView alloc] initWithFrame:CGRectMake(4.0f, 12.0f, 20.0f, 20.0f)];
                typeImage.backgroundColor = [UIColor clearColor];
                
                estimateImage = [[UIImageView alloc] initWithFrame:CGRectMake(30.0f, 9.0f, 12.0f, 12.0f)];        
                estimateImage.contentMode =  UIViewContentModeBottom;

        
                
                storyLabel = [[UILabel alloc] initWithFrame:CGRectMake(45.0f, 3.0f, (self.contentView.frame.size.width - 65.0f) , 25.0f)];
                storyLabel.autoresizingMask = UIViewAutoresizingNone;
                storyLabel.backgroundColor = [UIColor clearColor];
                storyLabel.highlightedTextColor = [UIColor whiteColor];
                storyLabel.font = [UIFont  systemFontOfSize:14.0f];
                storyLabel.textColor = [UIColor blackColor];
                storyLabel.textAlignment = UITextAlignmentLeft;
        
                
                statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(31.0f, 23.0f, (self.contentView.frame.size.width - 66.0f) , 15.0f)];
                statusLabel.autoresizingMask = UIViewAutoresizingNone;
                statusLabel.backgroundColor = [UIColor clearColor];
                statusLabel.highlightedTextColor = [UIColor whiteColor];
                statusLabel.font = [UIFont  systemFontOfSize:11.0f];
                statusLabel.textColor = [UIColor blackColor];
                statusLabel.textAlignment = UITextAlignmentLeft;
                
                
                
                UIView* backgroundView = [ [ [ UIView alloc ] initWithFrame:CGRectZero ] autorelease ];
                self.backgroundView = backgroundView;
                
                
                [self.contentView addSubview:typeImage];
                [self.contentView addSubview:estimateImage];        
                [self.contentView addSubview:storyLabel];        
                [self.contentView addSubview:statusLabel];                
                
                
        }
        return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
        [super setSelected:selected animated:animated];
    
        // Configure the view for the selected state
}


- (void)setStory:(PivotalStory *)theStory {
     
    
        storyLabel.text = theStory.name;
        statusLabel.text = theStory.currentState;
        UIColor *theColor;
            
        if ( [theStory.currentState hasPrefix:kStateAccepted] ) {
                theColor = [UIColor colorWithRed:216.0/255.0 green:238.0/255.0 blue:206.0/255.0 alpha:1.0];
        } else if ( [theStory.currentState hasPrefix:kStateStarted] || [theStory.currentState hasPrefix:kStateDelivered] ) {
                theColor = [UIColor colorWithRed:255.0/255.0 green:248.0/255.0 blue:228.0/255.0 alpha:1.0];
        } else if ( [theStory.currentState hasPrefix:kStateUnStarted] &&  [theStory.storyType hasPrefix:kStateRelease] ) {
//                theColor = [UIColor colorWithRed:64.0/255.0 green:122.0/255.0 blue:165.0/255.0 alpha:1.0];       
			statusLabel.textColor = [UIColor whiteColor];
			storyLabel.textColor = [UIColor whiteColor];
 			
                theColor = [UIColor colorWithRed:145.0/255.0 green:49.0/255.0 blue:50.0/255.0 alpha:1.0];        			
        } else if ( [theStory.currentState hasPrefix:kStateUnScheduled] ) {
                theColor = [UIColor colorWithRed:231.0/255.0 green:243.0/255.0 blue:250.0/255.0 alpha:1.0];        
                
        } else {
                theColor = [UIColor whiteColor];
        }
        
        estimateImage.image = [UIImage imageNamed: kIconEstimateNone];
        if ( theStory.estimate == 1 ) estimateImage.image = [UIImage imageNamed:kIconEstimateOnePoint];
        if ( theStory.estimate == 2 ) estimateImage.image = [UIImage imageNamed:kIconEstimateTwoPoints];    
        if ( theStory.estimate == 3 ) estimateImage.image = [UIImage imageNamed: kIconEstimateThreePoints];        
        
        if ( [theStory.storyType hasPrefix:kMatchBug] ) {    
                typeImage.image = [UIImage imageNamed:kIconTypeBug];        
        } else if ( [theStory.storyType hasPrefix:kMatchFeature] ) {
                typeImage.image = [UIImage imageNamed:kIconTypeFeature];
        } else if ( [theStory.storyType hasPrefix:kMatchChore] ) {
                typeImage.image = [UIImage imageNamed:kIconTypeChore];
                
        } else if ( [theStory.storyType hasPrefix:kMatchRelease] ) {
                typeImage.image = [UIImage imageNamed:kIconTypeRelease];        
        }
        
        [self.backgroundView setBackgroundColor:theColor];
}


- (void)dealloc {
        [typeImage release];
        [estimateImage release];
        [storyLabel release];
        [statusLabel release];    
        [super dealloc];
}


@end