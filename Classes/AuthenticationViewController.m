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
#import "PivotalTokenParserDelegate.h"


@implementation AuthenticationViewController

- (id)initWithTarget:(id)theTarget andSelector:(SEL)theSelector {
	[super initWithNibName:@"AuthenticationViewController" bundle:nil];
	target = theTarget;
	selector = theSelector;
    self.tableView.tableHeaderView = settingsHeader;
	usernameField.delegate = self;
	passwordField.delegate = self;	
	return self;
}

- (void)dealloc {
    [usernamCell release];
    [passwordCell release];    
    [settingsHeader release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [tableFooterView setBackgroundColor:[UIColor clearColor]];
    self.tableView.tableFooterView = tableFooterView;
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [usernameField becomeFirstResponder];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; }


#pragma mark UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	[theTextField resignFirstResponder];
	return YES;
}


-(IBAction)retrieveToken:(id)sender; {
    
    
	 NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;    
    
	
	
	ASIHTTPRequest *request = [[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:kUrlRetrieveToken]] autorelease];
	[request setUsername:[usernameField text]];
	[request setPassword:[passwordField text]];
	[request setShouldPresentCredentialsBeforeChallenge:YES];
	[request startSynchronous];
	BOOL success = [request authenticationRetryCount] == 1;	
	
	NSError *error = [request error];
	
#ifdef LOG_NETWORK	
    NSLog(@"%@", [request responseString]);
#endif   
	
	if ( !error ) {
   	  PivotalTokenParserDelegate *parserDelegate = [[PivotalTokenParserDelegate alloc] initWithTarget:self andSelector:@selector(parsedToken:)];
      NSXMLParser *parser = [[NSXMLParser alloc] initWithData:[request responseData]];
	  [parser setDelegate:parserDelegate];
	  [parser setShouldProcessNamespaces:NO];
	  [parser setShouldReportNamespacePrefixes:NO];
	  [parser setShouldResolveExternalEntities:NO];
	  [parser parse];  
	  [parser release];
  	  [parserDelegate release];
	} else {
		UIAlertView *alert;
		alert = [[UIAlertView alloc] initWithTitle:@"Authentication Failed" message:@"The username and/or password you provided are invalid. \nPlease try again." delegate:self cancelButtonTitle:@"okay" otherButtonTitles: nil];
		[alert show];
		[alert release];        
		
	}
	
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;    
    [pool release];        
    
}


- (void)parsedToken:(id)theResult {
    if ( [theResult isKindOfClass:[NSError class]]) {
		
		UIAlertView *alert;
		alert = [[UIAlertView alloc] initWithTitle:@"Problem Retrieving API Token" message:@"There was a problem retrieving your API Token from Pivotal Tracker. \n\nPlease try again, or check that your credentials are valid" delegate:self cancelButtonTitle:@"okay" otherButtonTitles: nil];
		[alert show];
		[alert release];        
		
		
		
    } else {
#ifdef LOG_NETWORK		
		NSLog(@"token is '%@'", [theResult objectAtIndex:0]);
#endif		
		NSCharacterSet *trimSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
		NSString *tokenkey = [theResult objectAtIndex:0];
		NSString *token_value = [tokenkey stringByTrimmingCharactersInSet:trimSet];
		if (![token_value isEqualToString:kEmptyString]) {
			NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
			[defaults setValue:token_value forKey:kDefaultsApiToken];
			[defaults synchronize];
			[target performSelector:selector];
		}   		
		
		
    }
}


#pragma mark User Defaults methods


- (IBAction)saveAuthenticationCredentials:(id)sender {
    
	NSCharacterSet *trimSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
	NSString *token_value = [usernameField.text stringByTrimmingCharactersInSet:trimSet];
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
    if ( indexPath.row == 0 ) return usernamCell;
    if ( indexPath.row == 1) return passwordCell;    
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}



@end

