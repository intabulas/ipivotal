#import "StoriesViewController.h"
#import "StoryViewController.h"
#import "AddStoryViewController.h"
#import "IterationStoryCell.h"
#import 
@implementation StoriesViewController

@synthesize storiesTableView;

- (id)initWithProject:(PivotalProject *)theProject andType:(NSString *)theType {
    [super init];
    project = theProject;
    storyType = theType;
    return self;
}




- (void)dealloc {
    [stories  removeObserver:self forKeyPath:kResourceStatusKeyPath];
    [storyType release];
    [stories release];
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    
    stories = [[PivotalStories alloc] initWithProject:project andType:storyType];
    [stories addObserver:self forKeyPath:kResourceStatusKeyPath options:NSKeyValueObservingOptionNew context:nil];
    if ( !stories.isLoaded) [stories loadStories];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = [storyType capitalizedString];
}


- (void)loadStories {
    if ( !stories.isLoaded ) [stories loadStories];    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:object change:change context:context {
    if ([keyPath isEqualToString:kResourceStatusKeyPath]) {
        PivotalStories *theStories = (PivotalStories *)object;
        if ( theStories.isLoading) {
        } else {         
     		[self.storiesTableView reloadData];
        }        
	}    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ( !stories.isLoaded) ? 1 : [stories.stories count];

}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSInteger row = indexPath.row;
    
    if ( stories.isLoading) return loadingCell;

    static NSString *CellIdentifier = @"IterationStoryCell";
    
    IterationStoryCell *cell = (IterationStoryCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[IterationStoryCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    [cell setStory:[stories.stories objectAtIndex:row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;  
    
    
	return cell;    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    StoryViewController *controller = [[StoryViewController alloc] initWithStory:[stories.stories objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
}


-(IBAction)addStory:(id)sender {
    AddStoryViewController *controller = [[AddStoryViewController alloc] initWithProject:project];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}


- (IBAction)refresh:(id)sender {
    
    [stories reloadStories];
    [self.storiesTableView reloadData];  
}



@end

