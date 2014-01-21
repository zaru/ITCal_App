//
//  MainViewController.h
//  ItCalc
//
//  Created by hiro on 2014/01/20.
//  Copyright (c) 2014年 hiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *items;

@end
