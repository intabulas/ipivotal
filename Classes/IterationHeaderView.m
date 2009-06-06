#import "IterationHeaderView.h"


@implementation IterationHeaderView

@synthesize titleLabel,dateLabel;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
          
        [self setBackgroundColor: [UIColor colorWithRed:76.0/255.0 green:76.0/255.0 blue:76.0/255.0 alpha:1.0]];
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 1, self.bounds.size.width, 20)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:14];
        titleLabel.textColor = [UIColor whiteColor];
        
        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 22, self.bounds.size.width, 10)];
        dateLabel.backgroundColor = [UIColor clearColor];
        dateLabel.font = [UIFont boldSystemFontOfSize:11];
        dateLabel.textColor = [UIColor whiteColor];
        dateLabel.text = @"no dates for this iteration yet";
        
        [self addSubview:titleLabel];
        [self addSubview:dateLabel];
        
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}



- (void)setIteration:(PivotalIteration*)iteration {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MMMM dd";
    titleLabel.text = [NSString stringWithFormat:@"Iteration %d", iteration.iterationId];  
    if ( iteration.startDate && iteration.endDate ) {
       dateLabel.text = [NSString stringWithFormat:@"%@ - %@", [dateFormatter stringFromDate:iteration.startDate], [dateFormatter stringFromDate:iteration.endDate]];
    }
    [dateFormatter release];        

}


- (void)dealloc {
    [titleLabel release];
    [dateLabel release];
    [super dealloc];
}


@end

