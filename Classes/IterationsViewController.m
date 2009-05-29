
#import "IterationsViewController.h"
#import "PivotalIteration.h"
#import "PivotalStory.h"
#import "IterationCell.h"
#import "StoriesViewController.h"
#import "StoryViewController.h"

@implementation IterationsViewController

@synthesize iterationTableView;

- (id)initWithProject:(PivotalProject *)theProject {
    [super init];
    project = theProject;
    return self;
}


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
    
    if ( iterations.isLoading) return loadingCell;
    
    PivotalIteration *iteration = [iterations.iterations objectAtIndex:section];


	StoryCell *cell = (StoryCell *)[tableView dequeueReusableCellWithIdentifier:@"StoryCell"];
	if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"StoryCell" owner:self options:nil];
		cell = storyCell;
	}
    
	cell.story = [iteration.stories objectAtIndex:row];
	return cell;   



}


- (UIView *)tableView: (UITableView *)tableView viewForHeaderInSection: (NSInteger)section {
    PivotalIteration *iteration = [iterations.iterations objectAtIndex:section];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateFormat = @"MMMM dd";
        
	UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.iterationTableView.bounds.size.width, 40)];
    [headerView setBackgroundColor: [UIColor colorWithRed:76.0/255.0 green:76.0/255.0 blue:76.0/255.0 alpha:1.0]];
	UILabel *labelOne = [[UILabel alloc] initWithFrame:CGRectMake(10, 1, headerView.bounds.size.width, 20)];
	labelOne.backgroundColor = [UIColor clearColor];
	labelOne.font = [UIFont boldSystemFontOfSize:14];
	labelOne.textColor = [UIColor whiteColor];
	if ( iterations.isLoaded ) labelOne.text = [NSString stringWithFormat:@"Iteration %d", iteration.iterationId];
    
	UILabel *labelTwo = [[UILabel alloc] initWithFrame:CGRectMake(10, 22, headerView.bounds.size.width, 10)];
	labelTwo.backgroundColor = [UIColor clearColor];
	labelTwo.font = [UIFont boldSystemFontOfSize:11];
	labelTwo.textColor = [UIColor whiteColor];
    if ( iterations.isLoaded ) labelTwo.text = [NSString stringWithFormat:@"%@ - %@", [dateFormatter stringFromDate:iteration.startDate], [dateFormatter stringFromDate:iteration.endDate]];
    
	[headerView addSubview:labelOne];
	[headerView addSubview:labelTwo];
    [dateFormatter release];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PivotalIteration *iteration = [iterations.iterations objectAtIndex:indexPath.section];

    StoryViewController *controller = [[StoryViewController alloc] initWithStory:[iteration.stories objectAtIndex:indexPath.row]];
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
    [iterations  removeObserver:self forKeyPath:kResourceStatusKeyPath];
    [loadingCell release];
    [doneStoriesButton release];
    [noIterationsCell release];
    [iterations release];
    [storyCell release];
    [super dealloc];
}


@end

