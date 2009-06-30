#import "TextFieldCell.h"

@implementation TextFieldCell

@synthesize textField;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        
        textField = [[UITextField alloc] initWithFrame:CGRectMake(10.0f, 13.0f, self.contentView.frame.size.width - 40.0f, self.contentView.frame.size.height - 10.0f)];
        textField.borderStyle = UITextBorderStyleNone;
        textField.placeholder = kTextStoryNeedsName;
		textField.font = [UIFont  systemFontOfSize:14.0f];
		textField.textColor = [UIColor blackColor];
        textField.returnKeyType = UIReturnKeyDone;
        
        [self.contentView addSubview:textField];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}


- (void)setText:(NSString*)text {
	textField.text = text;
}

- (NSString*)text {
	return textField.text;
}


- (void)dealloc {
    [textField release];
    [super dealloc];
}


@end

