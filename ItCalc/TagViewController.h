//
//  TagViewController.h
//  ItCalc
//
//  Created by hiro on 2014/01/25.
//  Copyright (c) 2014年 hiro. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Tag.h"

@interface TagViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, strong) Tag *tagDataCore;

@end
