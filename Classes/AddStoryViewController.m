#import "AddStoryViewController.h"
#import "LabelCell.h"
#import "ImageLabelCell.h"
#import "PivotalStory.h"

@implementation AddStoryViewController

@synthesize story;

- (id)initWithProject:(PivotalProject *)theProject {
    [super init];
    project = theProject;
    self.story = [[PivotalStory alloc] init];
    self.story.name = @"please give this story a title";
    return self;
}

- (void)dealloc {
    [story release];
    [storyTableView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Add Story";
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
    return  @"New Story Details" ;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;    
    
    if (  row == 0 ) {
        LabelCell *cell = (LabelCell*)[tableView dequeueReusableCellWithIdentifier:@"LabelCell"];
        if (cell == nil) {
            cell = [[LabelCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"LabelCell"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;        
        cell.text = self.story.name;
        return  cell;        
    }
    
    if ( row == 1 ) {
        ImageLabelCell *cell = (ImageLabelCell*)[tableView dequeueReusableCellWithIdentifier:@"ImageLabelCell"];
        if (cell == nil) {
            cell = [[ImageLabelCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"ImageLabelCell"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;        
        [cell setText:@"Feature"];   
        [cell setImage:[UIImage imageNamed:kIconTypeFeature]];
        return  cell;            
    }
    
    if ( row == 2 ) {
        ImageLabelCell *cell = (ImageLabelCell*)[tableView dequeueReusableCellWithIdentifier:@"ImageLabelCell"];
        if (cell == nil) {
            cell = [[ImageLabelCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"ImageLabelCell"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;        
        [cell setText:@"2 Points"];   
        [cell setImage:[UIImage imageNamed:kIconEstimateTwoPoints]];
        return  cell;            
    }
    
    if (  row == 3 ) {
        LabelCell *cell = (LabelCell*)[tableView dequeueReusableCellWithIdentifier:@"LabelCell"];
        if (cell == nil) {
            cell = [[LabelCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"LabelCell"] ;
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;        
        [cell setText:@"UnAssigned"];    
        return  cell;        
    }

    if (  row == 4 ) {
        LabelCell *cell = (LabelCell*)[tableView dequeueReusableCellWithIdentifier:@"LabelCell"];
        if (cell == nil) {
            cell = [[LabelCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"LabelCell"] ;
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;        
        [cell setText:@"please enter a description"];    
        return  cell;        
    }    
    
    
    return nil;
}




@end

