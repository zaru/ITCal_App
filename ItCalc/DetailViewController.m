//
//  DetailViewController.m
//  ItCal
//
//  Created by hiro on 2014/02/01.
//  Copyright (c) 2014年 hiro. All rights reserved.
//

#import "DetailViewController.h"
#import "UILabel+EstimatedHeight.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *eMessage;
@property (weak, nonatomic) IBOutlet UILabel *eTitle;
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
    
    self.eTitle.text = [self.detailData valueForKey:@"title"];
    self.eMessage.text = [self.detailData valueForKey:@"description"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openSafari:(id)sender {
    NSURL *url = [NSURL URLWithString:[self.detailData objectForKey:@"event_url"]];
    [[UIApplication sharedApplication] openURL:url];
}

/**
 *  セルの内包物によって高さを変更したいが…
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 *
 *  @return <#return value description#>
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
//    if (indexPath.row == 1) {
//        CGFloat height = [UILabel xx_estimatedHeight:[UIFont systemFontOfSize:12]
//                                                text:[self.detailData valueForKey:@"description"]
//                                                size:CGSizeMake(300, MAXFLOAT)];
//        CGFloat margin = 0;
//        
//        return height + margin;
//    } else {
        return 44;
//    }
}

@end
