
#import "TextInputController.h"


@implementation TextInputController

@synthesize listTableView, editingItem;

- (id)initWithTitle:(NSString *)theTitle {
    [super init];
    inputTitle = theTitle;
    return self;
}


#pragma mark UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	[theTextField resignFirstResponder];
	return YES;
}


- (IBAction) saveInput:(id)sender {
    [editingItem setValue:textField.text forKey:kKeyStoryName];
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
    
    [textInputCell setSelectionStyle:UITableViewCellSelectionStyleNone];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [textField becomeFirstResponder];
}

- (void)dealloc {
    [editingItem release];
    [textInputCell release];
    [textField release];
    [listTableView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return  inputTitle;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *storyName = (NSString *)[editingItem valueForKey:kKeyStoryName];
    if ( ![storyName isEqualToString:kDefaultStoryTitle] ) {
      [textField setText:storyName];
    }
    return textInputCell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}




@end

