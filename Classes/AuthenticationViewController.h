//
//  AuthenticationViewController.h
//  iPivotal
//
//  Created by Mark Lussier on 5/28/09.
//  Copyright 2009 Juniper Networks. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AuthenticationViewController : UITableViewController {
	id target;
	SEL selector;    
    IBOutlet UINavigationBar *settingsHeader;
    IBOutlet UITableViewCell *tokenCell;
    IBOutlet UITableViewCell *sslCell;    
    IBOutlet UITextField *tokenField;
    IBOutlet UISwitch *sslField; 
    
}

- (id)initWithTarget:(id)theTarget andSelector:(SEL)theSelector;


@end
