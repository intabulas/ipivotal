
#import "TextInputController.h"


@implementation TextInputController

@synthesize listTableView, editingItem;



#pragma mark UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	[theTextField resignFirstResponder];
	return YES;
}


- (IBAction) saveInput:(id)sender {
    [editingItem setValue:textField.text forKey:@"StoryName"];
    [self.navigationController popViewControllerAnimated:YES];    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
//// When the user presses return, take focus away from the text field so that the keyboard is dismissed.
////    if (theTextField == textField) {
//        [textField resignFirstResponder];
////        // Invoke the method that changes the greeting.
////        [self updateString];
//   // }
//    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [textField setDelegate:self];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveInput:)];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)dealloc {
    [editingItem release];
    [textInputCell release];
    [textField release];
    [listTableView release];
    [super dealloc];
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
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *storyName = (NSString *)[editingItem valueForKey:@"StoryName"];
    if ( ![storyName isEqualToString:kDefaultStoryTitle] ) {
      [textField setText:storyName];
    }
    return textInputCell;
//    TextFieldCell *cell = (TextFieldCell*)[listTableView dequeueReusableCellWithIdentifier:@"TextFieldCell"];
//    [cell.textField setDelegate:self];
//    if (cell == nil) {
//        cell = [[[TextFieldCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"TextFieldCell"] autorelease];
//    }
//    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
}




@end

