//
//  ListSelectionController.h
//  iPivotal
//
//  Created by Mark Lussier on 6/7/09.
//  Copyright 2009 Juniper Networks. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ListSelectionController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSArray *listItems;
    NSString *key;
    NSMutableDictionary *editingItem;
    UITableView *listTableView;
}

@property (nonatomic,retain) NSArray *listItems;
@property (nonatomic,retain) NSMutableDictionary *editingItem;
@property (nonatomic,retain) IBOutlet UITableView *listTableView;

- (id)initWithKey:(NSString *)theKey andTitle:(NSString *)theTitle;

@end
