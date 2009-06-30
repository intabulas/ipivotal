#import "AddStoryViewController.h"
#import "LabelCell.h"
#import "ImageLabelCell.h"
#import "PivotalStory.h"
#import "ListSelectionController.h"
#import "ASIHTTPRequest.h"
#import "PivotalResource.h"
#import "TextInputController.h"

@implementation AddStoryViewController

@synthesize story, editingDictionary;

- (id)initWithProject:(PivotalProject *)theProject {
    [super init];
    project = theProject;
    self.story = [[PivotalStory alloc] init];
    return self;
}

- (void)dealloc {
    [editingDictionary release];
    [story release];
    [storyTableView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveStory:)];
  //  [self.navigationItem.rightBarButtonItem setEnabled:NO];
}

- (void) saveStory:(id)sender {
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSString *urlString = [NSString stringWithFormat:kUrlAddStory, project.projectId];                            
	NSURL *followingURL = [NSURL URLWithString:urlString];    
    ASIHTTPRequest *request = [PivotalResource authenticatedRequestForURL:followingURL];
    NSString *newstory = [self.story to_xml];
    [request addRequestHeader:@"Content-type" value:@"application/xml"];
    [request setPostBody:[[NSMutableData alloc] initWithData:[newstory dataUsingEncoding:NSUTF8StringEncoding]]];
    [request start];
    [pool release];    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add Story" message:@"New story has been added to your Icebox" delegate:nil cancelButtonTitle:@"okay" otherButtonTitles: nil];
    [alert show];
    [alert release];        
    
    [self.navigationController popViewControllerAnimated:YES];    
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ( editingDictionary == nil ) {
        editingDictionary = [[NSMutableDictionary alloc] init];        
       [editingDictionary setObject:@"Feature" forKey:@"Type"];
       [editingDictionary setObject:kDefaultStoryTitle forKey:@"StoryName"];
       [editingDictionary setObject:[NSNumber numberWithInteger:0] forKey:@"Estimate"];        
    }
    
    story.name          = (NSString *)[editingDictionary valueForKey:@"StoryName"];
    story.storyType          = [editingDictionary valueForKey:@"Type"];
    NSNumber *estimateNumber = [editingDictionary valueForKey:@"Estimate"];
    story.estimate = [estimateNumber integerValue];
    
    
    
    
    
    self.title = @"Add Story";
    
    [storyTableView reloadData];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return  @"Add a New Story" ;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 5;  // if we have assignment 
//    return 4;  // if we have description
    return 3;    
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;    
    
    if (  row == 0 ) {
        LabelCell *cell = (LabelCell*)[tableView dequeueReusableCellWithIdentifier:@"LabelCell"];
        if (cell == nil) {
            cell = [[LabelCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"LabelCell"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;        
        [cell.cellLabel setText:self.story.name];
        return  cell;        
    }
    
    if ( row == 1 ) {
        ImageLabelCell *cell = (ImageLabelCell*)[tableView dequeueReusableCellWithIdentifier:@"ImageLabelCell"];
        if (cell == nil) {
            cell = [[ImageLabelCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"ImageLabelCell"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;      
        
        [cell.cellLabel setText:story.storyType];   
        
        if ( [story.storyType hasPrefix:@"Bug"] ) {    
            [cell setImage:[UIImage imageNamed:kIconTypeBug]];        
        } else if ( [self.story.storyType hasPrefix:@"Feature"] ) {
            [cell setImage:[UIImage imageNamed:kIconTypeFeature]];
        } else if ( [self.story.storyType hasPrefix:@"Chor"] ) {
            [cell setImage:[UIImage imageNamed:kIconTypeChore]];        
        } else if ( [self.story.storyType hasPrefix:@"Release"] ) {
            [cell setImage:[UIImage imageNamed:kIconTypeRelease]];
            
        }          
        
        return  cell;            
    }
    
    if ( row == 2 ) {
        ImageLabelCell *cell = (ImageLabelCell*)[tableView dequeueReusableCellWithIdentifier:@"ImageLabelCell"];
        if (cell == nil) {
            cell = [[ImageLabelCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"ImageLabelCell"];
        }
        [cell setContentMode:UIViewContentModeBottom];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;        
        [cell.cellLabel setText:[NSString stringWithFormat:@"%d Point(s)", story.estimate]];   
        
        if ( story.estimate == 0 ) [cell setImage:[UIImage imageNamed:kIconEstimateNone]];
        if ( story.estimate == 1 ) [cell setImage:[UIImage imageNamed:kIconEstimateOnePoint]];
        if ( story.estimate == 2 ) [cell setImage:[UIImage imageNamed:kIconEstimateTwoPoints]];    
        if ( story.estimate == 3 ) [cell setImage:[UIImage imageNamed:kIconEstimateThreePoints]];               
                                    
        return  cell;            
    }
    

    if (  row == 3  ) {  /// 4 if there is assignment
        LabelCell *cell = (LabelCell*)[tableView dequeueReusableCellWithIdentifier:@"LabelCell"];
        if (cell == nil) {
            cell = [[LabelCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"LabelCell"] ;
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;        
        [cell.cellLabel setText:@"please enter a description"];    
        return  cell;        
    }    
    
    
    return nil;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        TextInputController *controller = [[TextInputController alloc] init];

        controller.editingItem = editingDictionary;
        [editingDictionary setValue:story.name forKey:@"StoryName"];
        
        [self.navigationController pushViewController:controller animated:YES];
        
    }
    if (indexPath.row == 1) {
        ListSelectionController *controller = [[ListSelectionController alloc] initWithKey:@"Type" andTitle:@"Story Type"];
        controller.listItems = [[NSArray alloc] initWithObjects:@"Feature", @"Bug", @"Chore", @"Release", nil];
                        
        controller.editingItem = editingDictionary;
        [editingDictionary setValue:story.storyType forKey:@"Type"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.row == 2) {
        ListSelectionController *controller = [[ListSelectionController alloc] initWithKey:@"Estimate" andTitle:@"Point Estimate"];
        controller.listItems = [[NSArray alloc] initWithObjects:@"0 Points", @"1 Point", @"2 Points", @"3 Points", nil];
        
        controller.editingItem = editingDictionary;
        [editingDictionary setValue:[NSNumber numberWithInteger:story.estimate] forKey:@"Estimate"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    return indexPath;
}



@end

