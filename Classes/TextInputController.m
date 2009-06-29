
#import "TextInputController.h"
#import "TextFieldCell.h"

@implementation TextInputController

@synthesize listTableView;

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
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)dealloc {
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
    TextFieldCell *cell = (TextFieldCell*)[listTableView dequeueReusableCellWithIdentifier:@"TextFieldCell"];
    [cell.textField setDelegate:self];
    if (cell == nil) {
        cell = [[[TextFieldCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"TextFieldCell"] autorelease];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
}




@end

