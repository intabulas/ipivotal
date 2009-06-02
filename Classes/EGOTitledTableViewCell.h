//
//  EGOTitledTableViewCell.h
//  EGOClasses
//
//  Created by Shaun Harrison on 6/2/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EGOTitledTableViewCell : UITableViewCell {
@private
	UILabel* titleLabel;
	UILabel* textLabel;
}

@property(nonatomic,copy) NSString* title;
@property(nonatomic,readonly) UILabel* titleLabel;
@property(nonatomic,readonly) UILabel* textLabel;
@end