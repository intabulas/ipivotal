
#import "CommentCell.h"
#import "PivotalNote.h"
#import "NSDate+Nibware.h"

@implementation CommentCell
@synthesize comment;
- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}

-(CGFloat)getHeight {
 return   commentText.bounds.size.height;
}

- (void)setComment:(PivotalNote *)anComment {
	[comment release];
	comment = [anComment retain];    
    commentText.text = comment.text;
    [commentText sizeThatFits:commentText.bounds.size];
    anComment.visualHeight = commentText.bounds.size.height;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];
    


    // Configure the view for the selected state
}


- (void)dealloc {
    [commentText release];
    [super dealloc];
}


@end
