//
//  MainViewController.h
//  ItCalc
//
//  Created by hiro on 2014/01/20.
//  Copyright (c) 2014年 hiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "PickerViewController.h"

@interface MainViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, PickerViewControllerDelegate>

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

// 呼び出すPickerViewControllerのポインタ　※strongを指定してポインタを掴んでおかないと解放されてしまう
@property (strong, nonatomic) PickerViewController *pickerViewController;

// 「選択」ボタンがタップされたときに呼び出されるメソッド
- (IBAction)openPickerView:(id)sender;

@property (strong, nonatomic) NSString *searchWord;

@end
