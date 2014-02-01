//
//  PickerViewController.m
//  PickerViewSample
//
//  Created by Toshihide Tamura on 13/03/07.
//  Copyright (c) 2013年 tamurasouko. All rights reserved.
//

#import "PickerViewController.h"

@interface PickerViewController ()
@property (strong, nonatomic) NSString *selectedPref;
@end

@implementation PickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // PickerViewのデリゲート先とデータソースをこのクラスに設定
    self.picker.delegate = self;
    self.picker.dataSource = self;
    
    // 初期値
    self.selectedPref = [[self prefectures] objectAtIndex:13];
    [self.picker selectRow:13 inComponent:0 animated:NO];
}

// PickerViewで要素が選択されたときに呼び出されるメソッド
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedPref = [[self prefectures] objectAtIndex:row];
}

// PickerViewの列数を指定するメソッド
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView {
    return 1;
}

// PickerViewに表示する行数を指定するメソッド
-(NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [[self prefectures] count];
}

// PickerViewの各行に表示する文字列を指定するメソッド
-(NSString*)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [[self prefectures] objectAtIndex:row];
}

// 空の領域にある透明なボタンがタップされたときに呼び出されるメソッド
- (IBAction)closePickerView:(id)sender {
    // PickerViewを閉じるための処理を呼び出す
    [self.delegate applySelectedString:self.selectedPref];
    [self.delegate closePickerView:self];
}


// 都道府県リスト
-(NSArray*)prefectures
{
    NSArray* prefectures = [[NSArray alloc] initWithObjects:
                            @"すべて",@"北海道",@"青森県",@"岩手県",@"宮城県",@"秋田県",@"山形県",@"福島県",@"茨城県",@"栃木県",@"群馬県",
                            @"埼玉県",@"千葉県",@"東京都",@"神奈川県",@"新潟県",@"富山県",@"石川県",@"福井県",@"山梨県",@"長野県",
                            @"岐阜県",@"静岡県",@"愛知県",@"三重県",@"滋賀県",@"京都府",@"大阪府",@"兵庫県",@"奈良県",@"和歌山県",
                            @"鳥取県",@"島根県",@"岡山県",@"広島県",@"山口県",@"徳島県",@"香川県",@"愛媛県",@"高知県",@"福岡県",
                            @"佐賀県",@"長崎県",@"熊本県",@"大分県",@"宮崎県",@"鹿児島県",@"沖縄県", nil];
    return prefectures;
}

@end
