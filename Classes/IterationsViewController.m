#import "IterationsViewController.h"
#import "PivotalIteration.h"
#import "PivotalStory.h"
#import "IterationCell.h"
#import "StoriesViewController.h"
#import "StoryViewController.h"
#import "AddStoryViewController.h"
#import "IterationHeaderView.h"
#import "IterationStoryCell.h"
#import "ActivityLabelCell.h"
#import "CenteredLabelCell.h"
#import "ActivityViewController.h"
#import "NSDate+Nibware.h"

@implementation IterationsViewController
@synthesize iterationTableView, project;

- (id)initWithProject:(PivotalProject *)theProject {
    [super init];
    self.project = theProject;
    return self;
}

- (void)dealloc {
    [iterations  removeObserver:self forKeyPath:kResourceStatusKeyPath];
    [project release];
    [doneStoriesButton release];
    [iterations release];
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
	self.iterationTableView.tableHeaderView = updatedHeaderView;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    
    iterations = [[PivotalIterations alloc] initWithProject:self.project];
    [iterations addObserver:self forKeyPath:kResourceStatusKeyPath options:NSKeyValueObservingOptionNew context:nil];
    if ( !iterations.isLoaded) [iterations loadIterations];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"Current/Backlog";
    
    UISegmentedControl *segmentedControl = [[[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"done", @"current", @"backlog", nil]] autorelease];
    [segmentedControl addTarget:self action:@selector(iterationTypeChanged:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentedControl.selectedSegmentIndex = 1;
    self.navigationItem.titleView = segmentedControl;
    
    
}

- (void)iterationTypeChanged:(id)sender {
    if ( iterations.isLoaded ) {
    NSInteger selectedIndex = ((UISegmentedControl*)sender).selectedSegmentIndex;
    if ( selectedIndex == 0 ) {
        [iterations reloadInterationForGroup:@"done"];
    } else if ( selectedIndex == 1 ) {
        [iterations reloadInterationForGroup:@"current"];
    } else {
        [iterations reloadInterationForGroup:@"backlog"];        
    }
    }
}

- (void)loadIterations {
    if ( !iterations.isLoaded ) [iterations loadIterations];    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:kResourceStatusKeyPath]) {
        PivotalIterations *theIterations = (PivotalIterations *)object;
        if ( theIterations.isLoading) {
        } else {     
            lastUpdatedLabel.text = [NSString stringWithFormat:@"last updated %@", [iterations.lastUpdated prettyDate]];            
     		[self.iterationTableView reloadData];
        }        
	}    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (IBAction)refresh:(id)sender {
    
    [iterations reloadIterations];
    [self.iterationTableView reloadData];  
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return ( (!iterations.isLoaded) || (iterations.iterations.count == 0))  ? 1 : [iterations.iterations count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    if ( !iterations.isLoaded) return 1;
    if ( iterations.iterations.count == 0 ) return 1;
    PivotalIteration *iteration = [iterations.iterations objectAtIndex:section];
    return (iteration.stories.count == 0 ) ? 1 : iteration.stories.count;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    if (   iterations.iterations.count != 0 ) {
//     PivotalIteration *iteration = [iterations.iterations objectAtIndex:section];
//     return [NSString stringWithFormat:@"Iteration %d: start - end", [iteration iterationId]];
//    } else {
        return nil;;
//    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    
    if ( iterations.isLoaded && iterations.iterations.count == 0 ) {
        CenteredLabelCell *cell = (CenteredLabelCell*)[tableView dequeueReusableCellWithIdentifier:@"CenteredLabelCell"];
        if (cell == nil) {
            cell = [[[CenteredLabelCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"CenteredLabelCell"] autorelease];
        }
        [cell.cellLabel setText:@"there are no iterations for this phase"];

        return  cell;        
    }
    if ( !iterations.isLoaded) { 
        ActivityLabelCell *cell = (ActivityLabelCell*)[tableView dequeueReusableCellWithIdentifier:@"ActivityLabelCell"];
        if (cell == nil) {
            cell = [[[ActivityLabelCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"ActivityLabelCell"] autorelease];
        }
        [cell.cellLabel setText:@"Loading, please wait..."];
        [cell.activityView startAnimating];
        
        return  cell;
        
    }    
    
    PivotalIteration *iteration = [iterations.iterations objectAtIndex:section];
    
    if ( iteration.stories.count == 0 ) { 
        CenteredLabelCell *cell = (CenteredLabelCell*)[tableView dequeueReusableCellWithIdentifier:@"CenteredLabelCell"];
        if (cell == nil) {
            cell = [[[CenteredLabelCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"CenteredLabelCell"] autorelease];
        }
        [cell.cellLabel setText:@"you have no storied defined for this iteration"];    
        return  cell;
    }    
    
    
    static NSString *CellIdentifier = @"IterationStoryCell";
    
    IterationStoryCell *cell = (IterationStoryCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
       cell = [[[IterationStoryCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    [cell setStory:[iteration.stories objectAtIndex:row]];
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;  
    
}


- (UIView *)tableView: (UITableView *)tableView viewForHeaderInSection: (NSInteger)section {

   if ( iterations.isLoaded && iterations.iterations.count != 0 ) {    
    IterationHeaderView* headerView = [[[IterationHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.iterationTableView.bounds.size.width, 40)] autorelease];   
       [headerView setIteration:[iterations.iterations objectAtIndex:section]];
	return headerView; 
   } else {
     return nil;
   }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0f;
}

-(IBAction)showDoneStories:(id)sender {
    StoriesViewController *controller = [[StoriesViewController alloc] initWithProject:self.project andType:@"done"];
   [self.navigationController pushViewController:controller animated:YES];
   [controller release];
    
}


-(IBAction)showIceboxStories:(id)sender {
    StoriesViewController *controller = [[StoriesViewController alloc] initWithProject:self.project andType:@"icebox"];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
}

-(IBAction)projectActivity:(id)sender {
    ActivityViewController *controller = [[ActivityViewController alloc] initWithProject:self.project];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];	    
	
}

-(IBAction)addStory:(id)sender {
    AddStoryViewController *controller = [[AddStoryViewController alloc] initWithProject:self.project];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];        
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PivotalIteration *iteration = [iterations.iterations objectAtIndex:indexPath.section];

    StoryViewController *controller = [[StoryViewController alloc] initWithStory:[iteration.stories objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}




@end

