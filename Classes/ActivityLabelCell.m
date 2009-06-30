#import "ActivityLabelCell.h"

@implementation ActivityLabelCell

@synthesize cellLabel, activityView;


- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        
        cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(34.0f, 0.0f, (self.contentView.frame.size.width - 26.0f), self.contentView.frame.size.height)];
        cellLabel.autoresizingMask = UIViewAutoresizingNone;
        cellLabel.backgroundColor = [UIColor clearColor];
        cellLabel.highlightedTextColor = [UIColor whiteColor];
        cellLabel.font = [UIFont  systemFontOfSize:14.0f];
        cellLabel.textColor = [UIColor blackColor];
        cellLabel.textAlignment = UITextAlignmentLeft;
        [cellLabel setText:@"Loading, please wait..."];
    
        activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(6.0f, 13.0f, 20.0f, 20.0f)];
        activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        activityView.hidesWhenStopped = YES;
        
        [self.contentView addSubview:activityView]; 
        [self.contentView addSubview:cellLabel];
    
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];
}


- (void)dealloc {
    [cellLabel release];
    [activityView release];
    [super dealloc];
}


@end

