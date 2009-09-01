#import "StoriesViewController.h"
#import "StoryDetailViewController.h"
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

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    
    stories = [[PivotalStories alloc] initWithProject:project andType:storyType];
    [stories addObserver:self forKeyPath:kResourceStatusKeyPath options:NSKeyValueObservingOptionNew context:nil];
    if ( !stories.isLoaded) [stories loadStories];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = [storyType capitalizedString];
    [self refresh:self];
}


- (void)loadStories {
    if ( !stories.isLoaded ) [stories loadStories];    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:kResourceStatusKeyPath]) {
        PivotalStories *theStories = (PivotalStories *)object;
        if ( theStories.isLoading) {
        } else {         

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
        ActivityLabelCell *cell = (ActivityLabelCell*)[tableView dequeueReusableCellWithIdentifier:kIdentifierActivityLabelCell];
        if (cell == nil) {
            cell = [[[ActivityLabelCell alloc] initWithFrame:CGRectZero reuseIdentifier:kIdentifierActivityLabelCell] autorelease];
        }
        [cell.activityView startAnimating];
        return  cell;
        
    }
    
    
    if ( stories.stories.count == 0 ) { 
        CenteredLabelCell *cell = (CenteredLabelCell*)[tableView dequeueReusableCellWithIdentifier:kIdentifierCenteredCell];
        if (cell == nil) {
            cell = [[[CenteredLabelCell alloc] initWithFrame:CGRectZero reuseIdentifier:kIdentifierCenteredCell] autorelease];
        }
        [cell.cellLabel setText:kLabelNoStories];    
        return  cell;
    }
    
    static NSString *CellIdentifier = kIdentifierIterationStoryCell;
    
    IterationStoryCell *cell = (IterationStoryCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[IterationStoryCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    [cell setStory:[stories.stories objectAtIndex:row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
	return cell;    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    StoryDetailViewController *controller = [[StoryDetailViewController alloc] initWithStory:[stories.stories objectAtIndex:indexPath.row] andProject:project];
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

