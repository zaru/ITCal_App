//
//  DetailViewController.h
//  ItCal
//
//  Created by hiro on 2014/02/05.
//  Copyright (c) 2014年 hiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UIWebViewDelegate>
@property (strong, nonatomic) NSDictionary *detailData;
@end
