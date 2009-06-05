
#import "IterationsViewController.h"
#import "PivotalIteration.h"
#import "PivotalStory.h"
#import "IterationCell.h"
#import "StoriesViewController.h"
#import "StoryViewController.h"
#import "AddStoryViewController.h"
#import "IterationHeaderView.h"
#import "IterationStoryCell.h"


@implementation IterationsViewController
@synthesize iterationTableView;

- (id)initWithProject:(PivotalProject *)theProject {
    [super init];
    project = theProject;
    return self;
}

- (void)dealloc {
    [iterations  removeObserver:self forKeyPath:kResourceStatusKeyPath];
    [loadingCell release];
    [doneStoriesButton release];
    [noIterationsCell release];
    [iterations release];
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    
    iterations = [[PivotalIterations alloc] initWithProject:project];
    [iterations addObserver:self forKeyPath:kResourceStatusKeyPath options:NSKeyValueObservingOptionNew context:nil];
    if ( !iterations.isLoaded) [iterations loadIterations];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"Current/Backlog";
}


- (void)loadIterations {
    if ( !iterations.isLoaded ) [iterations loadIterations];    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:object change:change context:context {
    if ([keyPath isEqualToString:kResourceStatusKeyPath]) {
        PivotalIterations *theIterations = (PivotalIterations *)object;
        if ( theIterations.isLoading) {
        } else {         
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
    return ( !iterations.isLoaded) ? 1 : [iterations.iterations count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    if ( !iterations.isLoaded) return 0;
    PivotalIteration *iteration = [iterations.iterations objectAtIndex:section];
    return iteration.stories.count;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
   PivotalIteration *iteration = [iterations.iterations objectAtIndex:section];
   return [NSString stringWithFormat:@"Iteration %d: start - end", [iteration iterationId]];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    static NSString *CellIdentifier = @"IterationStoryCell";
    
    IterationStoryCell *cell = (IterationStoryCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[IterationStoryCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    PivotalIteration *iteration = [iterations.iterations objectAtIndex:section];
    [cell setStory:[iteration.stories objectAtIndex:row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;    
    
}


- (UIView *)tableView: (UITableView *)tableView viewForHeaderInSection: (NSInteger)section {
    IterationHeaderView* headerView = [[[IterationHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.iterationTableView.bounds.size.width, 40)] autorelease];   
    [headerView setIteration:[iterations.iterations objectAtIndex:section]];
	return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0f;
}

-(IBAction)showDoneStories:(id)sender {
    StoriesViewController *controller = [[StoriesViewController alloc] initWithProject:project andType:@"done"];
   [self.navigationController pushViewController:controller animated:YES];
   [controller release];
    
}


-(IBAction)showIceboxStories:(id)sender {
    StoriesViewController *controller = [[StoriesViewController alloc] initWithProject:project andType:@"icebox"];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
}

-(IBAction)addStory:(id)sender {
    AddStoryViewController *controller = [[AddStoryViewController alloc] initWithProject:project];
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

