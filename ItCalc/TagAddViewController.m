//
//  TagAddViewController.m
//  ItCalc
//
//  Created by hiro on 2014/01/26.
//  Copyright (c) 2014年 hiro. All rights reserved.
//

#import "TagAddViewController.h"

#import "Tag.h"

@interface TagAddViewController ()

@property (weak, nonatomic) IBOutlet UITextField *name;

@end

@implementation TagAddViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  お気に入りキーワード登録
 *
 *  @param sender <#sender description#>
 */
- (IBAction)submit:(id)sender {
    
    // お気に入りキーワードを追加
    Tag *tagDataCore = [[Tag alloc] init];
    [tagDataCore setValue:self.name.text forKey:CoreDataTagKey];
    
    // モーダルを閉じる
    [[self presentingViewController] dismissViewControllerAnimated:NO completion:nil];
}

/**
 *  モーダルを閉じる
 *
 *  @param sender <#sender description#>
 */
- (IBAction)close:(id)sender {
    [[self presentingViewController] dismissViewControllerAnimated:NO completion:nil];
}

@end
