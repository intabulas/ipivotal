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
#import "TaskViewController.h"
#import "PivotalStory.h"
#import "PivotalProject.h"
#import "PivotalTask.h"
#import "TaskCell.h"
#import "PivotalTaskParserDelegate.h"


@interface TaskViewController ()
    - (void)toggleTask:(PivotalTask *)toggleTask;
@end


@implementation TaskViewController

@synthesize taskTableView, story, project;



- (id)initWithProject:(PivotalProject *)theProject andStory:(PivotalStory *)theStory {
    [super init];
    project = [theProject retain];
    story = [theStory retain];
    return self;
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


- (void)viewDidLoad {
    [super viewDidLoad];    
 //   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(composeReply:)];
    [self setTitle:kLabelTasks];

    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [story release];
    [project release];
    [taskTableView release];
    [super dealloc];
}





#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [story.tasks  count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskCell *cell = (TaskCell*)[taskTableView dequeueReusableCellWithIdentifier:kIdentifierLabelCell];
    if (cell == nil) {
        cell = [[[TaskCell alloc] initWithFrame:CGRectZero reuseIdentifier:kIdentifierLabelCell] autorelease];
    }
    
    PivotalTask *task = [story.tasks objectAtIndex:indexPath.row];
    
    [cell.description setText:task.description];  
    [cell toggle:task.complete];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	TaskCell *newCell = (TaskCell*)[taskTableView cellForRowAtIndexPath:indexPath];
    PivotalTask *task = [story.tasks objectAtIndex:indexPath.row];  
    task.complete = !task.complete;
	[newCell toggle:!newCell.completed];
    [self toggleTask:task];
	[taskTableView deselectRowAtIndexPath:indexPath animated:YES];
	
}



#pragma mark Editing




- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        PivotalTask *task = [story.tasks  objectAtIndex:indexPath.row];
        [self deleteTask:task];
        [story.tasks removeObjectAtIndex:indexPath.row];
        [self.taskTableView reloadData];

        
    } 
}

- (void)deleteTask:(PivotalTask *)deleteTask {
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [self showHUDWithLabel:@"Deleting Task"];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;    
    NSString *urlString = [NSString stringWithFormat:kUrlUpdateTask, project.projectId, story.storyId, deleteTask.taskId];                            
	NSURL *followingURL = [NSURL URLWithString:urlString];    
    ASIHTTPRequest *request = [PivotalResource authenticatedRequestForURL:followingURL];
    [request setRequestMethod:@"DELETE"];
    [request startSynchronous];
#if LOG_NETWORKWORK    
    PTLog(@" Response: '%@'", [request responseString]);
#endif
    NSError *error = [request error];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;    
    [self hideHUD];
    if ( error ) {
        UIAlertView *alert;        
        alert = [[UIAlertView alloc] initWithTitle:@"Error Deleting Task" message:@"There was a problem deleting this task. Please try again later" delegate:self cancelButtonTitle:@"okay" otherButtonTitles: nil];
        [alert show];
        [alert release];            
    }
    [pool release];        
    
}

#pragma mark Add Task

- (IBAction)addTask:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add New Task" message:@"\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    newTaskField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 50.0, 260.0, 25.0)];
    [newTaskField setBackgroundColor:[UIColor whiteColor]];
    [newTaskField setPlaceholder:@"enter task name"];
    [alert addSubview:newTaskField];
    [alert show];
    [alert release];    
    [newTaskField becomeFirstResponder];    
}

- (void) alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex{    
    [newTaskField resignFirstResponder];
    
    if (buttonIndex == 1) { 
        
        
        
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        //            [self showHUDWithLabel:kLabelSaving];        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;    
        
        NSURL *followingURL = [NSURL URLWithString:[NSString stringWithFormat:kUrlAddTask, project.projectId, story.storyId]];    
        ASIHTTPRequest *request = [PivotalResource authenticatedRequestForURL:followingURL];
        NSString *newProject = [NSString stringWithFormat:kXmlAddTask, newTaskField.text];
        [request setRequestMethod:@"POST"];
        [request addRequestHeader:kHttpContentType value:kHttpMimeTypeXml];
        [request setPostBody:[[[NSMutableData alloc] initWithData:[newProject dataUsingEncoding:NSUTF8StringEncoding]]autorelease]];
        [request startSynchronous];
#if LOG_NETWORK    
        PTLog(@" Response: '%@'", [request responseString]);
#endif        
        
        NSError *error = [request error];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;    
        
        if ( error ) {
            UIAlertView *alert;        
            alert = [[UIAlertView alloc] initWithTitle:@"Error Adding Task" message:@"There was a problem adding a task to this story. Please try again later" delegate:self cancelButtonTitle:@"okay" otherButtonTitles: nil];
            [alert show];
            [alert release];            
        } else {
            PivotalTaskParserDelegate *parserDelegate = [[PivotalTaskParserDelegate alloc] initWithTarget:self andSelector:@selector(loadedTask:)];
            NSXMLParser *parser = [[NSXMLParser alloc] initWithData:[request responseData]];
            [parser setDelegate:parserDelegate];
            [parser setShouldProcessNamespaces:NO];
            [parser setShouldReportNamespacePrefixes:NO];
            [parser setShouldResolveExternalEntities:NO];
            [parser parse];
            [parser release];
            [parserDelegate release];  
        }
        [pool release];    
        
        [self.taskTableView reloadData];
//        [self.navigationController popViewControllerAnimated:YES];    
    } 
}

- (void)loadedTask:(id)theResult {
	if ([theResult isKindOfClass:[NSError class]]) {
//		self.error = theResult;
//		self.status = PivotalResourceStatusNotLoaded;
	} else {
		//self. = theResult;
        NSArray *tasks = theResult;
        if ( tasks.count > 0 ) {
            PivotalTask *tmpTask = [tasks objectAtIndex:0];        
            [story.tasks addObject:tmpTask];
        }
        
	}
}

- (void)toggleTask:(PivotalTask *)toggleTask {
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [self showHUDWithLabel:@"Toggling Task"];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;    
    NSString *urlString = [NSString stringWithFormat:kUrlUpdateTask, project.projectId, story.storyId, toggleTask.taskId];                            
	NSURL *followingURL = [NSURL URLWithString:urlString];    
    NSString *completeState = @"false";
    if ( toggleTask.complete ) {
        completeState = @"true";
    }
    
    
    NSString *updateTask = [NSString stringWithFormat:kXmlToggleTask, toggleTask.description, completeState];

    ASIHTTPRequest *request = [PivotalResource authenticatedRequestForURL:followingURL];
    [request setRequestMethod:@"PUT"];
    [request addRequestHeader:kHttpContentType value:kHttpMimeTypeXml];
    [request setPostBody:[[[NSMutableData alloc] initWithData:[updateTask dataUsingEncoding:NSUTF8StringEncoding]]autorelease]];
    [request startSynchronous];
    
#if LOG_NETWORK    
    PTLog(@" Response: '%@'", [request responseString]);
#endif
    NSError *error = [request error];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;    
    [self hideHUD];
    if ( error ) {
        UIAlertView *alert;        
        alert = [[UIAlertView alloc] initWithTitle:@"Error Toggling Task" message:@"There was a problem toggling this task. Please try again later" delegate:self cancelButtonTitle:@"okay" otherButtonTitles: nil];
        [alert show];
        [alert release];            
    }
    [pool release];        
    
}




@end
