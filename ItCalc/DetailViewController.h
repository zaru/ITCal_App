//
//  DetailViewController.h
//  ItCal
//
//  Created by hiro on 2014/02/01.
//  Copyright (c) 2014年 hiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSDictionary *detailData;

@end
