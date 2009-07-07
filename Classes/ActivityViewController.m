#import "ActivityViewController.h"
#import "ActivityItemCell.h"
#import "PivotalProject.h"
#import "NSDate+Nibware.h"


@implementation ActivityViewController

- (id)init {
    [super initWithNibName:@"ActivityViewController" bundle:nil];
    return self;
}

- (id)initWithProject:(PivotalProject *)theProject {
    [self init];
    project = theProject;
    return self;
}

- (void)dealloc {
	[loadingActivitiesCell release];
    [updatedHeaderView release];
    [lastUpdatedLabel release];
	[noActivitiesCell release];
	[activities removeObserver:self forKeyPath:kResourceStatusKeyPath];
	[activities release];
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    #ifdef CACHED_CONTENT
	self.tableView.tableHeaderView = updatedHeaderView;
    #endif

	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];

    activities = [[PivotalActivities alloc] initWithProject:project];
	[activities addObserver:self forKeyPath:kResourceStatusKeyPath options:NSKeyValueObservingOptionNew context:nil];

	if ( !activities.isLoaded) [ activities loadActivities];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"Activity";
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:kResourceStatusKeyPath]) {
        PivotalActivities *theActivities = (PivotalActivities *)object;
        if ( theActivities.isLoading) {
        } else {         
            lastUpdatedLabel.text = [NSString stringWithFormat:kFormatLastUpdated, [activities.lastUpdated prettyDate]];
     		[self.tableView reloadData];
        }        
	}    
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (IBAction)refresh:(id)sender {
    [activities reloadActivities];
    [self.tableView reloadData];   	
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 	( activities.isLoading || activities.activities.count == 0) ? 1 : activities.activities.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	
	if ( !activities.isLoaded) return loadingActivitiesCell;
	if ( activities.isLoaded && activities.activities.count == 0 ) return noActivitiesCell;
	
	
    static NSString *CellIdentifier = @"ActivityItemCell";
    
    ActivityItemCell *cell = (ActivityItemCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[ActivityItemCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    [cell setActivity:[activities.activities objectAtIndex:indexPath.row]];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   // @todo
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 60.0f;
}

@end

