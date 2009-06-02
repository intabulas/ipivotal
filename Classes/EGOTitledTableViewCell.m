//
//  EGOTitledTableViewCell.m
//  EGOClasses
//
//  Created by Shaun Harrison on 6/2/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import "EGOTitledTableViewCell.h"


@implementation EGOTitledTableViewCell
@synthesize titleLabel, textLabel;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f) reuseIdentifier:reuseIdentifier]) {
		float titleWidth = floor(self.contentView.frame.size.width * .30);
		float textWidth = self.contentView.frame.size.width - titleWidth - 10.0f;
		
		titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, titleWidth, self.contentView.frame.size.height)];
		titleLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
		titleLabel.backgroundColor = [UIColor clearColor];
		titleLabel.highlightedTextColor = [UIColor whiteColor];
		titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
		titleLabel.textColor = [UIColor grayColor];
		titleLabel.textAlignment = UITextAlignmentRight;
        
		textLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleWidth+10.0f, 0.0f, textWidth, self.contentView.frame.size.height)];
		textLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		textLabel.backgroundColor = [UIColor clearColor];
		textLabel.highlightedTextColor = [UIColor whiteColor];
		textLabel.font = [UIFont boldSystemFontOfSize:17.0f];
		
		[self.contentView addSubview:titleLabel];
		[self.contentView addSubview:textLabel];
    }
    
    return self;
}

- (void)setText:(NSString*)text {
	textLabel.text = text;
}

- (NSString*)text {
	return textLabel.text;
}

- (void)setTitle:(NSString*)title {
	titleLabel.text = title;
}

- (NSString*)title {
	return titleLabel.text;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)dealloc {
	[titleLabel release];
	[textLabel release];
    [super dealloc];
}


@end