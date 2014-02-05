//
//  MainViewController.m
//  ItCalc
//
//  Created by hiro on 2014/01/20.
//  Copyright (c) 2014年 hiro. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"

@interface MainViewController ()
@property (strong, nonatomic) UIActivityIndicatorView *ai;
@property (strong, nonatomic) UIView *indiView;
@property int currentPage;
@property (strong, nonatomic) NSString *selectedPref;
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
    
    // 初期ページ数を設定
    self.currentPage = 1;
    
    // 検索時のキーワードをタイトルバーへ
    if (self.searchWord) {
        self.title = self.searchWord;
    }
    
    // TableViewのひっぱって更新
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                            action:@selector(refreshing:)
                  forControlEvents:UIControlEventValueChanged];
    [self setRefreshControl:self.refreshControl];
    
    // API読み込みインジケータ
    self.indiView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    self.indiView.backgroundColor = [UIColor blackColor];
    self.indiView.alpha = 0.8f;
    self.indiView.center = self.view.center;
    self.indiView.layer.cornerRadius = 5;
    self.indiView.hidden = YES;
    self.ai = [[UIActivityIndicatorView alloc] init];
    self.ai.frame = CGRectMake(5, 5, 50, 50);
    self.ai.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    [self.indiView addSubview:self.ai];
    // tableviewcontrollerに載せるとスクロールに対応できないのでnavigationControllerにする
    [self.navigationController.view addSubview:self.indiView];
    
    // iOS6対応
    if (![CommonFunctions isIOS7]) {
        [[[self navigationController] navigationBar] setTintColor:[UIColor colorWithRed:61/255.0 green:60/255.0 blue:62/255.0 alpha:1.0]];
    }
    
//    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tab"]];
    
    // TableViewに初期データ + JSON読み込み
    self.items = [NSArray array];
    [self getJSON];
    
    // TableViewが空の場合は罫線を表示しないようにする
    self.tableView.tableFooterView = [[UIView alloc] init];
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
    NSDictionary *item = [[self.items objectAtIndex:indexPath.row] objectForKey:@"Event"];
    
    {
        UILabel *lTitle = (UILabel *)[cell viewWithTag:1];
        lTitle.text = [item objectForKey:@"title"];
    }
    {
        UILabel *lPref = (UILabel *)[cell viewWithTag:2];
        lPref.text = [item objectForKey:@"pref"];
    }
    {
        UILabel *lCapacity = (UILabel *)[cell viewWithTag:3];
        lCapacity.text = [NSString stringWithFormat:@"応募 %@名／定員 %@名", [item objectForKey:@"applicant"], [item objectForKey:@"capacity"]];
    }
    {
        UILabel *lYear = (UILabel *)[cell viewWithTag:4];
        lYear.text = [item objectForKey:@"year"];
    }
    {
        UILabel *lDay = (UILabel *)[cell viewWithTag:5];
        lDay.text = [item objectForKey:@"day"];
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
//    [self performSegueWithIdentifier:@"detailData" sender:self];
}

/**
 *  View遷移
 *
 *  @param segue  <#segue description#>
 *  @param sender <#sender description#>
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // 気になるワードでの検索結果へ遷移
    if ([[segue identifier] isEqualToString:@"detailData"]) {
        
        // 選択されたキーワードを取得
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *targetData = [self.items objectAtIndex:indexPath.row];
        
        DetailViewController *viewController = (DetailViewController*)[segue destinationViewController];
        viewController.detailData = [targetData objectForKey:@"Event"];
    }
}

/**
 *  最後のセルが表示されたら次頁を自動で読み込む
 *
 *  @param tableView <#tableView description#>
 *  @param cell      <#cell description#>
 *  @param indexPath <#indexPath description#>
 */
-(void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= (self.currentPage) * ListNum - 1) {
        self.currentPage++;
        [self getJSON];
    }
}

/**
 *  JSONファイルをネットワーク越しに取得して、TableViewを更新する
 */
- (void)getJSON {
    [self getJSON:NO];
}

- (void)getJSON:(BOOL)isAllClear {
    // インジケータ表示
    self.indiView.hidden = NO;
    [self.ai startAnimating];
    
    self.selectedPref = (self.selectedPref) ? self.selectedPref : @"";
    self.searchWord = (self.searchWord) ? self.searchWord : @"";
    
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:ApiUri,
                                        (self.currentPage - 1) * ListNum + 1,
                                        ListNum,
                                        self.selectedPref,
                                        self.searchWord]
                                       stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        // 検索時など既存データをクリアする場合
        if (isAllClear) {
            self.items = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        } else {
            // ページング処理の場合は、すでに表示させているデータを保持する
            NSArray *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *tmp = self.items;
            
            // アプリデータの配列をプロパティに保持
            self.items = [tmp arrayByAddingObjectsFromArray:jsonDictionary];
        }
        
        // 読み込みインジケータを消す
        [self.refreshControl endRefreshing];
        
        self.indiView.hidden = YES;
        [self.ai stopAnimating];
        
        // TableView をリロード
        [self.tableView reloadData];
        
        // 自動ページングの場合、分かりやすいように、ちょっと上にスクロールさせる
        if (self.currentPage > 1) {
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:(self.currentPage - 1) * ListNum - 7 inSection:0];
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }];
}



// 「選択」ボタンがタップされたときに呼び出されるメソッド
- (IBAction)openPickerView:(id)sender {
    // PickerViewControllerのインスタンスをStoryboardから取得し
    self.pickerViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"PickerViewController"];
    self.pickerViewController.delegate = self;
    
    // PickerViewをサブビューとして表示する
    // 表示するときはアニメーションをつけて下から上にゆっくり表示させる
    
    // アニメーション完了時のPickerViewの位置を計算
    UIView *pickerView = self.pickerViewController.view;
    CGPoint middleCenter = pickerView.center;
    
    // アニメーション開始時のPickerViewの位置を計算
    UIWindow* mainWindow = (((AppDelegate*) [UIApplication sharedApplication].delegate).window);
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    CGPoint offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);
    pickerView.center = offScreenCenter;
    
    [mainWindow addSubview:pickerView];
    
    // アニメーションを使ってPickerViewをアニメーション完了時の位置に表示されるようにする
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    pickerView.center = middleCenter;
    [UIView commitAnimations];
}

// PickerViewのある行が選択されたときに呼び出されるPickerViewControllerDelegateプロトコルのデリゲートメソッド
- (void)applySelectedString:(NSString *)str
{
    self.selectedPref = str;
    if ([self.selectedPref isEqualToString:@"すべて"]) {
        self.title = @"勉強会";
    } else {
        self.title = self.selectedPref;
    }
    [self getJSON:YES];
}

// PickerViewController上にある透明ボタンがタップされたときに呼び出されるPickerViewControllerDelegateプロトコルのデリゲートメソッド
- (void)closePickerView:(PickerViewController *)controller
{
    // PickerViewをアニメーションを使ってゆっくり非表示にする
    UIView *pickerView = controller.view;
    
    // アニメーション完了時のPickerViewの位置を計算
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    CGPoint offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);
    
    [UIView beginAnimations:nil context:(void *)pickerView];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    // アニメーション終了時に呼び出す処理を設定
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    pickerView.center = offScreenCenter;
    [UIView commitAnimations];
}

// 単位のPickerViewを閉じるアニメーションが終了したときに呼び出されるメソッド
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    // PickerViewをサブビューから削除
    UIView *pickerView = (__bridge UIView *)context;
    [pickerView removeFromSuperview];
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
