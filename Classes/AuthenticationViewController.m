//
//	Copyright (c) 2008-2009, Mark Lussier
//	http://github.com/intabulas/ipivotal
//	All rights reserved.
//
//	This software is released under the terms of the BSD License.
//	http://www.opensource.org/licenses/bsd-license.php
//
//	Redistribution and use in source and binary forms, with or without modification,
//	are permitted provided that the following conditions are met:
//
//	* Redistributions of source code must retain the above copyright notice, this
//	  list of conditions and the following disclaimer.
//	* Redistributions in binary form must reproduce the above copyright notice,
//	  this list of conditions and the following disclaimer
//	  in the documentation and/or other materials provided with the distribution.
//	* Neither the name of iPivotal nor the names of its contributors may be used
//	  to endorse or promote products derived from this software without specific
//	  prior written permission.
//
//	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//	ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
//	IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
//	INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
//	BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
//	DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
//	LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
//	OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
//	OF THE POSSIBILITY OF SUCH DAMAGE.
//

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
    self.tableView.tableFooterView = tableFooterView;
    
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
    [alert release];
    
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *username = [NSString stringWithString:[usernameField text]];
    NSString *password = [NSString stringWithString:[passwordField text]];    

    [alertView release];    
}

- (void)authenticationNeededForRequest:(ASIHTTPRequest *)request {
    NSLog(@"DOH");
}
//-(IBAction)retrieveToken:(id)sender; {
//    
//   // [self lookupToken:sender];
//	
//    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
//		
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;    
//    
//	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//	NSString *urlString = [NSString stringWithFormat:kUrlRetrieveToken, @"mlussier", @"kjgbu45n"];
//	ASIHTTPRequest *request = [[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlString]] autorelease];
//
//#ifdef LOG_NETWORK
//	NSLog( @"Curl Test:  curl -H \"X-TrackerToken: %@\" -X GET %@", @"SDD", [NSURL URLWithString:kUrlRetrieveToken] );
//#endif
//		
//    [request start];
//    NSLog(@"Result :'%@' '%d'", [request error], [request responseStatusCode]);
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;    
//    [pool release];        
//    
//}
//
//- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
//  [self retrieveToken:self];    
//    
//}

-(IBAction)retrieveToken:(id)sender; {
    
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;    
    
    NSURLCredentialStorage *storage = [NSURLCredentialStorage sharedCredentialStorage];
	//    [storage credentialsForProtectionSpace:<#(NSURLProtectionSpace *)space#>
    
    ASIHTTPRequest *request = [[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:kUrlRetrieveToken]] autorelease];  

    [request setShouldPresentAuthenticationDialog:YES];
	[request setUseSessionPersistance:NO];
    [request start];
    NSLog(@"Result :'%@' '%d'", [request error], [request responseStatusCode]);
	
#ifdef LOG_NETWORK	
    NSLog(@"%@", [request responseString]);
#endif   
	
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;    
    [pool release];        
    
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
    return 1; //2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    if ( indexPath.row == 0 ) return tokenCell;
    //if ( indexPath.row == 1) return sslCell;    
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


@end

