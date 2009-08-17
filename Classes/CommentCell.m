
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

- (void)setComment:(PivotalNote *)anComment {
	[comment release];
	comment = [anComment retain];    
    commentText.text = comment.text;
    fromLabel.text = [NSString stringWithFormat:@"%@ said %@", comment.author, [comment.createdAt prettyDate] ];
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
