#import "StoriesViewController.h"
#import "StoryViewController.h"
#import "AddStoryViewController.h"
#import "IterationStoryCell.h"
#import "CenteredLabelCell.h"
#import "ActivityLabelCell.h"
#import "NSDate+Nibware.h"


@implementation StoriesViewController

@synthesize storiesTableView;

- (id)initWithProject:(PivotalProject *)theProject andType:(NSString *)theType {
    [super init];
    project = [theProject retain];
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
    
    self.storiesTableView.tableHeaderView = updatedHeaderView;
    
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

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:kResourceStatusKeyPath]) {
        PivotalStories *theStories = (PivotalStories *)object;
        if ( theStories.isLoading) {
        } else {         
            lastUpdatedLabel.text = [NSString stringWithFormat:kFormatLastUpdated, [stories.lastUpdated prettyDate]];                        
     		[self.storiesTableView reloadData];
        }        
	}    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ( !stories.isLoaded || stories.stories.count == 0 ) ? 1 : [stories.stories count];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSInteger row = indexPath.row;
    
    if ( stories.isLoading) { 
        ActivityLabelCell *cell = (ActivityLabelCell*)[tableView dequeueReusableCellWithIdentifier:@"ActivityLabelCell"];
        if (cell == nil) {
            cell = [[[ActivityLabelCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"ActivityLabelCell"] autorelease];
        }
        [cell.activityView startAnimating];
        return  cell;
        
    }
    
    
    if ( stories.stories.count == 0 ) { 
        CenteredLabelCell *cell = (CenteredLabelCell*)[tableView dequeueReusableCellWithIdentifier:@"CenteredLabelCell"];
        if (cell == nil) {
            cell = [[[CenteredLabelCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"CenteredLabelCell"] autorelease];
        }
        [cell.cellLabel setText:@"there are no stories defined"];    
        return  cell;
    }
    
    static NSString *CellIdentifier = @"IterationStoryCell";
    
    IterationStoryCell *cell = (IterationStoryCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[IterationStoryCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    [cell setStory:[stories.stories objectAtIndex:row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
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

