
#import "ProjectLabelCell.h"

@implementation ProjectLabelCell

@synthesize cellLabel;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        
        cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, self.contentView.frame.size.width - 10.0f, self.contentView.frame.size.height)];
		cellLabel.autoresizingMask = UIViewAutoresizingNone;
		cellLabel.backgroundColor = [UIColor clearColor];
		cellLabel.highlightedTextColor = [UIColor whiteColor];
		cellLabel.font = [UIFont  boldSystemFontOfSize:17.0f];
		cellLabel.textColor = [UIColor blackColor];
		cellLabel.textAlignment = UITextAlignmentLeft;
        
        [self.contentView addSubview:cellLabel];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}


- (void)setText:(NSString*)text {
	cellLabel.text = text;
}

- (NSString*)text {
	return cellLabel.text;
}


- (void)dealloc {
    [cellLabel release];
    [super dealloc];
}


@end

