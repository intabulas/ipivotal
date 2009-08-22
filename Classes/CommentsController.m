#import "CommentsController.h"
#import "PivotalNote.h"
#import "CommentCell.h"
#import "PivotalStory.h"
#import "PivotalProject.h"
#import "CommentHeaderView.h"
#import "AddCommentController.h"

@implementation CommentsController

-(id)initWithProject:(PivotalProject *)theProject andStory:(PivotalStory *)theStory {
       [super initWithNibName:@"CommentsController" bundle:nil];
    project = theProject;
    story = theStory;
    comments = story.comments;    
    return self;

}


-(id)initWithComments:(NSArray *)theComments {

    [super initWithNibName:@"CommentsController" bundle:nil];
    
    comments = theComments;
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [commentTableView reloadData];
    [commentTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:(story.comments.count - 1 )] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(composeReply:)];

    
    [self setTitle:@"Comments"];

}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [comments count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView: (UITableView *)tableView viewForHeaderInSection: (NSInteger)section {
     CommentHeaderView* headerView = [[[CommentHeaderView alloc] initWithFrame:CGRectMake(0, 0, commentTableView.bounds.size.width, 40)] autorelease];   
     [headerView setNote:[comments objectAtIndex:section]];
     return headerView; 
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    PivotalNote *note = [comments objectAtIndex:section];
//    return [NSString stringWithFormat:@"%@ said", note.author];
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"CommentCell";
    
    CommentCell *cell = (CommentCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:self options:nil];        
        cell = commentCell;
    }
    
    PivotalNote *note = (PivotalNote *)[comments objectAtIndex:indexPath.section];
    
    [cell setComment:note];
    // Set up the cell...
	
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 75.0f;
}



- (void)dealloc {
    [super dealloc];
}


#pragma mark Add Comments

-(void)composeReply:(id)sender {

    PivotalNote *note = [[[PivotalNote alloc] initWithProject:project
                                                    andStory:story] autorelease];
    [story.comments addObject:note];
    AddCommentController *controller = [[AddCommentController alloc] initWithNote:note];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
    
}




@end

