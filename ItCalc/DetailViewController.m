//
//  DetailViewController.m
//  ItCal
//
//  Created by hiro on 2014/02/01.
//  Copyright (c) 2014年 hiro. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *url;
@end

@implementation DetailViewController

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
    
    self.url.text = self.detailData;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openSafari:(id)sender {
    NSURL *url = [NSURL URLWithString:self.detailData];
    [[UIApplication sharedApplication] openURL:url];
}

@end
