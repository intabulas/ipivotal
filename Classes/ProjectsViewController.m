//
//	Copyright (c) 2008-2010, Mark Lussier
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

#import "ProjectsViewController.h"
#import "PivotalProject.h"
#import "IterationsViewController.h"
#import "ImageLabelCell.h"
#import "iPivotalAppDelegate.h"
#import "ActivityViewController.h"
#import "NSDate+Nibware.h"
#import "MBProgressHUD.h"
#import "ProjectInfoViewController.h"
#import "PlaceholderCell.h"
#import "DynamicCell.h"

@implementation ProjectsViewController

@synthesize projectTableView, hudDisplayed;

static UIFont *boldFont;

- (void)dealloc {
    [newProjectField release];
    [projects removeObserver:self forKeyPath:kResourceStatusKeyPath];
    [projects release]; projects = nil;
    [noProjectsCell release]; noProjectsCell = nil;
    [projectTableView release]; projectTableView = nil;
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addProject:)];
   
    projects = [[PivotalProjects alloc] init];
    [projects addObserver:self forKeyPath:kResourceStatusKeyPath options:NSKeyValueObservingOptionNew context:nil];
    

    
    newProjectField = [[UITextField alloc] initWithFrame:CGRectMake(14, 45, 255, 23)];

	
	newProjectField.borderStyle = UITextBorderStyleBezel;
	newProjectField.textColor = [UIColor blackColor];
	newProjectField.textAlignment = UITextAlignmentCenter;
	newProjectField.font = [UIFont systemFontOfSize:14.0];
	newProjectField.placeholder = @"enter project name";
    
	newProjectField.backgroundColor = [UIColor whiteColor];
	newProjectField.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
	
//	emailField.keyboardType = UIKeyboardTypeEmailAddress;	// use the default type input method (entire keyboard)
	newProjectField.returnKeyType = UIReturnKeyDone;
//	newProjectField.delegate = self;
	newProjectField.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right

    
    
    
    
    
}

- (void)displayHUD {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    HUD = [[MBProgressHUD alloc] initWithWindow:window];
    [window addSubview:HUD];
    HUD.delegate = self;
    [HUD setLabelText:kLabelLoading];
    hudDisplayed = YES;
    [HUD  show:YES];    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = kLabelProjects;
}
- (IBAction)refreshProjectList:(id)sender; {}

- (void)reloadProjects {
	[projects reloadProjects];
}

- (void)loadProjects {
    if ( !projects.isLoaded ) [projects loadProjects];    
    [projects loadProjects];    	
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:kResourceStatusKeyPath]) {
         
        PivotalProjects *theProjects = (PivotalProjects *)object;
    
        if ( theProjects.isLoading) {
        } else {         
            [self hideHeadsUpDisplay];
     		[self.projectTableView reloadData];

        }        
	}    
}


#pragma mark Actions

- (IBAction)logout:(id)sender {
    // @TODO
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:kDefaultsApiToken];
    iPivotalAppDelegate *appdelegate = (iPivotalAppDelegate *)[[UIApplication sharedApplication]delegate];
	[appdelegate authenticate];
}


- (IBAction)refresh:(id)sender {
    [self displayHUD];
    [projects  reloadProjects];
    [self.projectTableView reloadData];     
}

- (IBAction)recentActivity:(id)sender {
    ActivityViewController *controller = [[ActivityViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];	
}


- (IBAction)addProject:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add New Project" message:@"\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    newProjectField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 50.0, 260.0, 25.0)];
    [newProjectField setBackgroundColor:[UIColor whiteColor]];
    [newProjectField setPlaceholder:@"enter project name"];
    [alert addSubview:newProjectField];
    [alert setTransform:CGAffineTransformMakeTranslation(0.0, 110.0)];
    [alert show];
    [alert release];    
    [newProjectField becomeFirstResponder];
    
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  (projects.isLoading  || projects.projects.count == 0) ? 1 : projects.projects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if ( !projects.isLoaded && !self.hudDisplayed) { [self displayHUD]; } 
    
    iPivotalAppDelegate *appdelegate = (iPivotalAppDelegate *)[[UIApplication sharedApplication]delegate];

    if ( [appdelegate hasNoInternetConnectivity]) return noProjectsCell;
	if (projects.isLoaded && projects.projects.count == 0) return noProjectsCell;
    
    if ( !projects.isLoaded) { 
        PlaceholderCell *cell = (PlaceholderCell*)[tableView dequeueReusableCellWithIdentifier:kIdentifierPlaceholderCell];
        if (cell == nil) {
            cell = [[[PlaceholderCell alloc] initWithFrame:CGRectZero reuseIdentifier:kIdentifierPlaceholderCell] autorelease];
        }
        return  cell;
        
    }       
    
    static float defaultFontSize = 17.0;
    if ( boldFont == nil ) {
        boldFont = [[UIFont boldSystemFontOfSize:defaultFontSize] retain];        
    }
    
    
    DynamicCell *cell = (DynamicCell*)[tableView dequeueReusableCellWithIdentifier:@"InfoCell"];
    if ( cell == nil ) {
        cell = [DynamicCell cellWithReuseIdentifier:@"InfoCell"];
        cell.defaultFont = [UIFont systemFontOfSize:defaultFontSize];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;        
    }
    [cell reset];    
    
    PivotalProject *pp = [projects.projects objectAtIndex: indexPath.row];

    
    NSLog( @"Spacing %d", [cell rowSpacing]);
    
    UILabel *projectName = [cell addLabelWithText:pp.name andFont:boldFont];
    projectName.highlightedTextColor = [UIColor whiteColor];

    UILabel *updatedLabel = [cell addLabelWithText:[NSString stringWithFormat:kLableProjectActivity, [pp.lastActivityAt prettyDate]] andFont:[UIFont systemFontOfSize:10.0]];
    updatedLabel.textColor = [UIColor grayColor];
    updatedLabel.highlightedTextColor = [UIColor whiteColor];


    [cell prepare];                             
    return cell;       
}

- (CGFloat) tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    UITableViewCell* cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return [cell respondsToSelector:@selector(height)] ? 
    [[cell performSelector:@selector(height)] floatValue] : 
    tableView.rowHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath { 
    if ( projects.isLoaded && projects.projects.count > 0 ) {
       PivotalProject *project = [projects.projects objectAtIndex:indexPath.row];
	   IterationsViewController *controller = [[IterationsViewController alloc] initWithProject:project];  
	   [self.navigationController pushViewController:controller animated:YES];
  	   [controller release];    
    }
}


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if ( projects.isLoaded && projects.projects.count > 0 ) {
        PivotalProject *project = [projects.projects objectAtIndex:indexPath.row];
        ProjectInfoViewController *controller = [[ProjectInfoViewController alloc] initWithProject:project];  
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];    
    }
}




- (void)hideHeadsUpDisplay {
    if ( hudDisplayed ) {
      hudDisplayed = NO;
      [HUD hide:YES];
    }
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden {
    // Remove HUD from screen when the HUD was hidded
    hudDisplayed = NO;
    [HUD removeFromSuperview];
    [HUD release];
}


#pragma mark UIAlertViewDelegate Methods
- (void) alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex{    
    if (buttonIndex == 1) { 
        
            [newProjectField resignFirstResponder];
            
            
            NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
//            [self showHUDWithLabel:kLabelSaving];        
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;    

            NSURL *followingURL = [NSURL URLWithString:kUrlAddProject];    
            ASIHTTPRequest *request = [PivotalResource authenticatedRequestForURL:followingURL];
            NSString *newProject = [NSString stringWithFormat:kXmlAddProject, newProjectField.text, 2];
            [request setRequestMethod:@"POST"];
            [request addRequestHeader:kHttpContentType value:kHttpMimeTypeXml];
            [request setPostBody:[[[NSMutableData alloc] initWithData:[newProject dataUsingEncoding:NSUTF8StringEncoding]]autorelease]];
            [request startSynchronous];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;    
  //          [self hideHUD];
            [pool release];    
            
            [self.navigationController popViewControllerAnimated:YES];    
        
        [self refresh:self];
    }
}

@end

