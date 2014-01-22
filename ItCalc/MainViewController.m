//
//  MainViewController.m
//  ItCalc
//
//  Created by hiro on 2014/01/20.
//  Copyright (c) 2014年 hiro. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // TableViewのひっぱって更新
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                            action:@selector(refreshing:)
                  forControlEvents:UIControlEventValueChanged];
    [self setRefreshControl:self.refreshControl];
    
    // TableViewに初期データ + JSON読み込み
    self.items = [NSArray array];
    [self getJSON];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 *  再読み込み
 *
 *  @param refreshControl <#refreshControl description#>
 */
-(void)refreshing:(UIRefreshControl*)refreshControl
{
    [self getJSON];
}

#pragma mark - TableViewの設定
/**
 *  TableViewセクションの数
 *
 *  @param tableView <#tableView description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/**
 *  TableViewRowの個数
 *
 *  @param tableView <#tableView description#>
 *  @param section   <#section description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}

/**
 *  TableViewRowのデータ配置
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 *
 *  @return <#return value description#>
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // カスタムセルの取得
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    {
        UILabel *lTitle = (UILabel *)[cell viewWithTag:1];
        NSDictionary *item = [self.items objectAtIndex:indexPath.row];
        lTitle.text = [item objectForKey:@"title"];
    }
    {
        UILabel *lCapacity = (UILabel *)[cell viewWithTag:3];
        NSDictionary *item = [self.items objectAtIndex:indexPath.row];
        lCapacity.text = [NSString stringWithFormat:@"応募 %@名／定員 %@名", [item objectForKey:@"accepted"], [item objectForKey:@"limit"]];
    }
    return cell;
}

/**
 *  TableViewRow選択アクション
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"selectRow" sender:self];
}

/**
 *  JSONファイルをネットワーク越しに取得して、TableViewを更新する
 */
- (void)getJSON
{
    NSURL *url = [NSURL URLWithString:@"http://connpass.com/api/v1/event/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        // アプリデータの配列をプロパティに保持
        self.items = [jsonDictionary objectForKey:@"events"];
        
        // 読み込みインジケータを消す
        [self.refreshControl endRefreshing];
        
        // TableView をリロード
        [self.tableView reloadData];
    }];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
