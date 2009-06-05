#import "AddStoryViewController.h"


@implementation AddStoryViewController


- (id)initWithProject:(PivotalProject *)theProject {
    [super init];
    project = theProject;
    return self;
}

- (void)dealloc {
    [storyTableView release];
    [nameCell release];
    [typeCell release];    
    [estimateCell release];
    [stateCell release];
    [descriptionCell release];    
    [nameField release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [nameField becomeFirstResponder];
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
    return 2;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return ( section == 0 ) ? @"Details" : @"Description";
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ( section == 1 ) ? 1 : 4;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;    
    
    if ( section == 0 && row == 0 ) return nameCell;
    if ( section == 0 && row == 1 ) return typeCell;    
    if ( section == 0 && row == 2 ) return estimateCell;
    if ( section == 0 && row == 3 ) return stateCell;
    if ( section == 1 && row == 0 ) return descriptionCell;    

    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.section == 1 ) ? 103.0f : 40.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}





@end

