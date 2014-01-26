//
//  TagAddViewController.m
//  ItCalc
//
//  Created by hiro on 2014/01/26.
//  Copyright (c) 2014年 hiro. All rights reserved.
//

#import "TagAddViewController.h"

@interface TagAddViewController ()

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

- (IBAction)closeModalDialog:(id)sender {
    [[self presentingViewController] dismissViewControllerAnimated:NO completion:nil];
}

@end
