//
//  TagAddViewController.h
//  ItCalc
//
//  Created by hiro on 2014/01/26.
//  Copyright (c) 2014年 hiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface TagAddViewController : UIViewController

@property (nonatomic, readonly) NSManagedObjectContext * managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end
