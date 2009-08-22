#import "CommentHeaderView.h"
#import "NSDate+Nibware.h"

@implementation CommentHeaderView

@synthesize commentImage, commentTitle;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        
       // [self setBackgroundColor: [UIColor colorWithRed:154.0/255.0 green:154.0/255.0 blue:154.0/255.0 alpha:1.0]];
//        [self setBackgroundColor: [UIColor colorWithRed:76.0/255.0 green:76.0/255.0 blue:76.0/255.0 alpha:1.0]];
        [self setBackgroundColor:[UIColor blackColor]];
        
        commentImage = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 26.0f, 22.0f)];
        commentImage.backgroundColor = [UIColor clearColor];
        commentImage.contentMode = UIViewContentModeCenter;
        commentImage.image = [UIImage imageNamed:kIconCommentSmall];
        
        commentTitle = [[UILabel alloc] initWithFrame:CGRectMake(30.0f, -15.0f, (self.frame.size.width - 30.0f) , self.frame.size.height)];
		commentTitle.autoresizingMask = UIViewAutoresizingNone;
		commentTitle.backgroundColor = [UIColor clearColor];
		commentTitle.highlightedTextColor = [UIColor whiteColor];
		commentTitle.font = [UIFont  systemFontOfSize:12.0f];
		commentTitle.textColor = [UIColor whiteColor];
		commentTitle.textAlignment = UITextAlignmentLeft;
        
        [self addSubview:commentImage];
        [self addSubview:commentTitle];
        
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}



- (void)setNote:(PivotalNote *)note {
    commentTitle.text = [NSString stringWithFormat:kLabelCommentHeader, note.author, [note.createdAt prettyDate] ];
}


- (void)dealloc {
    [commentTitle release];
    [commentImage release];
    [super dealloc];
}


@end

