#import "ProjectsViewController.h"
#import "PivotalProject.h"
#import "IterationsViewController.h"
#import "ImageLabelCell.h"
#import "ProjectLabelCell.h"
#import "iPivotalAppDelegate.h"
#import "ActivityViewController.h"
#import "NSDate+Nibware.h"

@implementation ProjectsViewController

@synthesize projectTableView;

- (void)dealloc {
    [projects removeObserver:self forKeyPath:kResourceStatusKeyPath];
    [projects release];
    [loadingProjectsCell release];
    [noProjectsCell release];
    [projectTableView release];
    [super dealloc];
}


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
    [projects  reloadProjects];
    [self.projectTableView reloadData];    
}

- (IBAction)recentActivity:(id)sender {
    ActivityViewController *controller = [[ActivityViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];	
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  (projects.isLoading  || projects.projects.count == 0) ? 1 : projects.projects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    iPivotalAppDelegate *appdelegate = (iPivotalAppDelegate *)[[UIApplication sharedApplication]delegate];

    if ( [appdelegate hasNoInternetConnectivity]) return noProjectsCell;
	if (!projects.isLoaded ) return loadingProjectsCell;
	if (projects.isLoaded && projects.projects.count == 0) return noProjectsCell;
	
    ProjectLabelCell *cell = (ProjectLabelCell*)[tableView dequeueReusableCellWithIdentifier:@"ProjectLabelCell"];
    if (cell == nil) {
        cell = [[[ProjectLabelCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    
    
    PivotalProject *pp = [projects.projects objectAtIndex: indexPath.row];
    [cell.cellLabel setText:pp.name];
    	
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



@end

