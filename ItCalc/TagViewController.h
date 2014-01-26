//
//  TagViewController.h
//  ItCalc
//
//  Created by hiro on 2014/01/25.
//  Copyright (c) 2014年 hiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface TagViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, readonly) NSManagedObjectContext * managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end
