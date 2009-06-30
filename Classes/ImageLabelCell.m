
#import "ImageLabelCell.h"


@implementation ImageLabelCell

@synthesize cellImage, cellLabel;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        
        
        cellImage = [[UIImageView alloc] initWithFrame:CGRectMake(4.0f, 7.0f, 30.0f, 30.0f)];
        cellImage.contentMode = UIViewContentModeCenter;

        cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(36.0f, 0.0f, (self.contentView.frame.size.width - 36.0f) , self.contentView.frame.size.height)];
		cellLabel.autoresizingMask = UIViewAutoresizingNone;
		cellLabel.backgroundColor = [UIColor clearColor];
		cellLabel.highlightedTextColor = [UIColor whiteColor];
		cellLabel.font = [UIFont  systemFontOfSize:14.0f];
		cellLabel.textColor = [UIColor blackColor];
		cellLabel.textAlignment = UITextAlignmentLeft;
        
        
        [self.contentView addSubview:cellImage];
		[self.contentView addSubview:cellLabel];
    }
    return self;
}

- (void)setImageContentMode:(UIViewContentMode)contentMode {
    cellImage.contentMode = contentMode;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setText:(NSString*)text {
	cellLabel.text = text;
}

- (NSString*)text {
	return cellLabel.text;
}

- (void)setImage:(UIImage*)theimage {
    cellImage.image = theimage;
}

- (UIImage*)image {
	return cellImage.image;
}

- (void)dealloc {
    [cellImage release];
    [cellLabel release];
    [super dealloc];
}


@end
