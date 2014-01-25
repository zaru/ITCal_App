//
//  PickerViewController.m
//  PickerViewSample
//
//  Created by Toshihide Tamura on 13/03/07.
//  Copyright (c) 2013年 tamurasouko. All rights reserved.
//

#import "PickerViewController.h"

@interface PickerViewController ()

@end

@implementation PickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // PickerViewのデリゲート先とデータソースをこのクラスに設定
    self.picker.delegate = self;
    self.picker.dataSource = self;
}

// PickerViewで要素が選択されたときに呼び出されるメソッド
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // デリゲート先の処理を呼び出し、選選択された文字列を親Viewに表示させる
//    [self.delegate applySelectedString:[NSString stringWithFormat:@"%d", row]];
}

// PickerViewの列数を指定するメソッド
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView {
    return 1;
}

// PickerViewに表示する行数を指定するメソッド
-(NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 10;
}

// PickerViewの各行に表示する文字列を指定するメソッド
-(NSString*)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [NSString stringWithFormat:@"%d", row];
}

// 空の領域にある透明なボタンがタップされたときに呼び出されるメソッド
- (IBAction)closePickerView:(id)sender {
    // PickerViewを閉じるための処理を呼び出す
    [self.delegate closePickerView:self];
}

@end
