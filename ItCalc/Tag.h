//
//  Tag.h
//  ItCalc
//
//  Created by hiro on 2014/01/26.
//  Copyright (c) 2014年 hiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Const.h"

@interface Tag : NSObject <NSFetchedResultsControllerDelegate>

@property (nonatomic, readonly) NSManagedObjectContext * managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end
