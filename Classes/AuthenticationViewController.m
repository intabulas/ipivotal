#import "AuthenticationViewController.h"
#import "ASIHTTPRequest.h"

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
    
    [tableFooterView setBackgroundColor:[UIColor clearColor]];
    //self.tableView.tableFooterView = tableFooterView;
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [tokenField becomeFirstResponder];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; }


#pragma mark UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	[theTextField resignFirstResponder];
	return YES;
}


#pragma mark  UIAlertViewDelegate Stuff

-(IBAction)lookupToken:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Lookup API Token" 
                          message:@"Lookup Pivotal Tracker API Token"
                          delegate:self
                          cancelButtonTitle:@"Cancel" 
                          otherButtonTitles:@"Lookup", nil];
    
    [alert addTextFieldWithValue:@"" label:@"Username"];
    [alert addTextFieldWithValue:@"" label:@"Password"];    
    
    usernameField = [alert textFieldAtIndex:0];
    usernameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    usernameField.keyboardType = UIKeyboardTypeAlphabet;
    usernameField.keyboardAppearance = UIKeyboardAppearanceAlert;
    usernameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    usernameField.autocorrectionType = UITextAutocorrectionTypeNo;

    passwordField = [alert textFieldAtIndex:1];
    passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordField.keyboardType = UIKeyboardTypeAlphabet;
    passwordField.keyboardAppearance = UIKeyboardAppearanceAlert;
    passwordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    passwordField.autocorrectionType = UITextAutocorrectionTypeNo;
    passwordField.secureTextEntry = YES;
    
    [alert show];
    
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *username = [NSString stringWithString:[usernameField text]];
    NSString *password = [NSString stringWithString:[passwordField text]];    

    [alertView release];    
}

-(IBAction)retrieveToken:(id)sender; {
    
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;    
    
    
    
    ASIHTTPRequest *request = [[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:kUrlRetrieveToken]] autorelease];
    [request setUsername:@"mlussier"];    
    [request setPassword:@"kjgbu45n"]; 
    
    NSLog(@"URL: %@  USERNAME: %@   PASSSORD:  %@", [request url], [request username], [request password]);
    [request start];
    [request retryWithAuthentication];
    NSLog(@"Result :'%@' '%d'", [request error], [request responseStatusCode]);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;    
    [pool release];        
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
  [self retrieveToken:self];    
    
}


#pragma mark User Defaults methods


- (IBAction)saveAuthenticationCredentials:(id)sender {
    
	NSCharacterSet *trimSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
	NSString *token_value = [tokenField.text stringByTrimmingCharactersInSet:trimSet];
	if (![token_value isEqualToString:kEmptyString]) {
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



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    if ( indexPath.row == 0 ) return tokenCell;
    if ( indexPath.row == 1) return sslCell;    
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


@end

