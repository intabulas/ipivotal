#import "AuthenticationViewController.h"

@implementation AuthenticationViewController

- (id)initWithTarget:(id)theTarget andSelector:(SEL)theSelector {
	[super initWithNibName:@"AuthenticationViewController" bundle:nil];
	target = theTarget;
	selector = theSelector;
    self.tableView.tableHeaderView = settingsHeader;
	tokenField.delegate = self;
	
	return self;
}

- (void)dealloc {
    [tokenCell release];
    [sslCell release];    
    [tokenField release];
    [sslField release];     
    [settingsHeader release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    tokenField.text = [defaults valueForKey:kDefaultsApiToken];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [tokenField becomeFirstResponder];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
}


#pragma mark UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	[theTextField resignFirstResponder];
	return YES;
}

#pragma mark User Defaults methods


- (IBAction)saveAuthenticationCredentials:(id)sender {
    
	NSCharacterSet *trimSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
	NSString *token_value = [tokenField.text stringByTrimmingCharactersInSet:trimSet];
	if (![token_value isEqualToString:@""]) {
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		[defaults setValue:token_value forKey:kDefaultsApiToken];
		[defaults synchronize];
		[target performSelector:selector];
    }    
    
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}



// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ( indexPath.row == 0 ) return tokenCell;
    if ( indexPath.row == 1) return sslCell;    
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


@end

