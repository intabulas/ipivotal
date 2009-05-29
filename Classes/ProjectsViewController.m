#import "ProjectsViewController.h"
#import "ProjectCell.h"
#import "PivotalProject.h"
#import "IterationsViewController.h"

@implementation ProjectsViewController

@synthesize projectTableView;

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];

    projects = [[PivotalProjects alloc] init];
    [projects addObserver:self forKeyPath:kResourceStatusKeyPath options:NSKeyValueObservingOptionNew context:nil];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"Projects";
}


- (void)loadProjects {
   if ( !projects.isLoaded ) [projects loadProjects];    
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:object change:change context:context {
    if ([keyPath isEqualToString:kResourceStatusKeyPath]) {
        PivotalProjects *theProjects = (PivotalProjects *)object;
        if ( theProjects.isLoading) {
        } else {         
//            lastUpdatedLabel.text = [NSString stringWithFormat:@"last updated %@", [tasks.lastUpdated prettyDate]];            
     		[self.projectTableView reloadData];
        }        
	}    
}


#pragma mark Table view methods

- (IBAction)logout:(id)sender {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults removeObjectForKey:kDefaultsApiToken];
    
}

- (IBAction)refresh:(id)sender {
    [projects  reloadProjects];
    [self.projectTableView reloadData];    
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  (projects.isLoading ) || (projects.projects.count == 0) ? 1 : projects.projects.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSInteger row = indexPath.row;    
    
    if ( projects.isLoading) return loadingProjectsCell;
    if ( projects.projects.count == 0) return noProjectsCell;
    
    
	ProjectCell *cell = (ProjectCell *)[tableView dequeueReusableCellWithIdentifier:@"ProjectCell"];
	if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"ProjectCell" owner:self options:nil];
		cell = projectCell;
	}

	cell.project = [projects.projects objectAtIndex:row];
	return cell;        
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PivotalProject *project = [projects.projects objectAtIndex:indexPath.row];
	IterationsViewController *controller = [[IterationsViewController alloc] initWithProject:project];
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
    [projects removeObserver:self forKeyPath:kResourceStatusKeyPath];
    [projects release];
    [projectCell release];
    [loadingProjectsCell release];
    [noProjectsCell release];
    [projectTableView release];
    [super dealloc];
}


@end

