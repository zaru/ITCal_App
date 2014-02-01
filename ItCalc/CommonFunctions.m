//
//  CommonFunctions.m
//  ItCal
//
//  Created by hiro on 2014/02/01.
//  Copyright (c) 2014年 hiro. All rights reserved.
//

#import "CommonFunctions.h"

@implementation CommonFunctions

/**
*  iOS7かどうかの判定
*
*  @return boolean
*/
+ (BOOL)isIOS7
{
    NSArray  *aOsVersions = [[[UIDevice currentDevice]systemVersion] componentsSeparatedByString:@"."];
    NSInteger iOsVersionMajor  = [[aOsVersions objectAtIndex:0] intValue];
    return (iOsVersionMajor == 7);
}

@end
