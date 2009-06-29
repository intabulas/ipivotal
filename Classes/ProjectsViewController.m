#import "ProjectsViewController.h"
#import "PivotalProject.h"
#import "IterationsViewController.h"
#import "ImageLabelCell.h"

@implementation ProjectsViewController

@synthesize projectTableView;

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

- (void)reloadProjects {
	[projects reloadProjects];
}

- (void)loadProjects {
   if ( !projects.isLoaded ) [projects loadProjects];    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
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
    // @TODO
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:kDefaultsApiToken];
    
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

	
	if (projects.isLoading ) return loadingProjectsCell;
	if (projects.projects.count == 0) return noProjectsCell;
	
    static NSString *CellIdentifier = @"ImageLabelCell";
    
    ImageLabelCell *cell = (ImageLabelCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[ImageLabelCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    PivotalProject *pp = [projects.projects objectAtIndex: indexPath.row];
    [cell.cellLabel setText:pp.name];
    cell.image = [UIImage imageNamed:kIconTypeProject];
    	
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
	
    return cell;    
    
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PivotalProject *project = [projects.projects objectAtIndex:indexPath.row];
	IterationsViewController *controller = [[IterationsViewController alloc] initWithProject:project];
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];
    
}



- (void)dealloc {
    [projects removeObserver:self forKeyPath:kResourceStatusKeyPath];
    [projects release];
    [loadingProjectsCell release];
    [noProjectsCell release];
    [projectTableView release];
    [super dealloc];
}


@end

