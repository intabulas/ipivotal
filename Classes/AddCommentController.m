#import "AddCommentController.h"
#import "PivotalResource.h"
#import "PivotalNote.h"


@implementation AddCommentController

- (void)dealloc {
    [note release];
    [super dealloc];
}


-(id)initWithNote:(PivotalNote *)theNote {
    [super initWithNibName:@"AddComment" bundle:nil];
	note = [theNote retain];
    return self;    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Add Comment";
	self.tableView.tableFooterView = tableFooterView;    
    [note addObserver:self forKeyPath:kResourceSavingStatusKeyPath options:NSKeyValueObservingOptionNew context:nil];

}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:kResourceSavingStatusKeyPath]) {
		if (note.isSaving) return;
		if ( note.isSaved) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Comment Added" message:@"Still working on Refres code" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];
		} else if (note.error) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Request error" message:@"There was a problem adding your comment" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
        
        saveButton.enabled = YES;
		[activityView stopAnimating];

	}
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


- (IBAction)saveNote:(id)sender {
    [note setText:commentBody.text];
	saveButton.enabled = NO;
	[activityView startAnimating];
	[note saveNote];
}


#pragma mark -
#pragma mark Keyboard

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[commentBody resignFirstResponder];
	return YES;
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {  	
    return commentCell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 125.0f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}



@end

