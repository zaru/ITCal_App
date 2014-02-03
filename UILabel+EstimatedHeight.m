//
//  UILabel+UILabel_EstimatedHeight.m
//  ItCal
//
//  Created by hiro on 2014/02/02.
//  Copyright (c) 2014年 hiro. All rights reserved.
//

#import "UILabel+EstimatedHeight.h"

@implementation UILabel (UILabel_EstimatedHeight)

+ (CGFloat)xx_estimatedHeight:(UIFont *)font text:(NSString *)text size:(CGSize)size
{
    NSDictionary *attributes = @{NSFontAttributeName: font};
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    CGRect rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    return rect.size.height;
}

@end
