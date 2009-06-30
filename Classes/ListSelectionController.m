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
    NSIndexPath *tableSelection = [listTableView indexPathForSelectedRow];
	[listTableView deselectRowAtIndexPath:tableSelection animated:NO];
    [listTableView reloadData];
}


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [editingItem setValue:[listItems objectAtIndex:indexPath.row] forKey:key];
    [self.navigationController popViewControllerAnimated:YES];
    return indexPath;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; 
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [listItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LabelCell *cell = (LabelCell*)[listTableView dequeueReusableCellWithIdentifier:@"LabelCell"];
    if (cell == nil) {
        cell = [[[LabelCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"LabelCell"] autorelease];
    }

    [cell.cellLabel setText:[listItems objectAtIndex:indexPath.row]];
        
    NSObject *sobject = [editingItem valueForKey:key];
    if ( [sobject isKindOfClass:[NSNumber class]] ) {
        NSInteger index = [(NSNumber*)sobject integerValue];
        [cell setAccessoryType:(indexPath.row == index ) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone ];
        
    } else {
        
      [cell setAccessoryType:([[listItems objectAtIndex:indexPath.row] isEqualToString:[editingItem valueForKey:key]]) ? 
        UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone];
    }
        
    return cell;
}


@end

