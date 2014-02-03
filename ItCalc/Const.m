//
//  const.m
//  ItCalc
//
//  Created by hiro on 2014/01/27.
//  Copyright (c) 2014年 hiro. All rights reserved.
//

#import "Const.h"

@implementation Const

NSString * const CoreDataName = @"Tag";
NSString * const CoreDataEntityName = @"Tag";
NSString * const CoreDataTagKey = @"name";
int const ListNum = 20;

NSString * const ApiUri = @"http://itcal.tofu-kun.org/api/search.json?start=%d&count=%d";
NSString * const ApiUriKeyword = @"http://itcal.tofu-kun.org/api/search.json?keyword=%@&start=%d&count=%d";

@end
