#import "ListSelectionController.h"
#import "LabelCell.h"

@implementation ListSelectionController

@synthesize listItems, editingItem, listTableView;

- (id)initWithKey:(NSString *)theKey andTitle:(NSString *)theTitle {
    [super init];
    self.navigationItem.title = theTitle;
    key = [theKey retain];
    return self;
}

- (void)dealloc {
    [listItems release];
    [listTableView release];
    [editingItem  release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
    // Remove any previous selection.
    NSIndexPath *tableSelection = [listTableView indexPathForSelectedRow];
	[listTableView deselectRowAtIndexPath:tableSelection animated:NO];
    [listTableView reloadData];
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    NSObject *sobject = [editingItem valueForKey:key];
    if ( [sobject isKindOfClass:[NSNumber class]] ) {
        NSInteger index = [(NSNumber*)sobject integerValue];
        return (indexPath.row == index ) ?      UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;

    } else {
    
    return ([[listItems objectAtIndex:indexPath.row] isEqualToString:[editingItem valueForKey:key]]) ? 
                    UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [editingItem setValue:[listItems objectAtIndex:indexPath.row] forKey:key];
    [self.navigationController popViewControllerAnimated:YES];
    return indexPath;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [listItems count];
}

// The table uses standard UITableViewCells. The text for a cell is simply the string value of the matching type.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LabelCell *cell = (LabelCell*)[listTableView dequeueReusableCellWithIdentifier:@"LabelCell"];
    if (cell == nil) {
        cell = [[[LabelCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"LabelCell"] autorelease];
    }
    [cell.cellLabel setText:[listItems objectAtIndex:indexPath.row]];
    return cell;
}


@end

