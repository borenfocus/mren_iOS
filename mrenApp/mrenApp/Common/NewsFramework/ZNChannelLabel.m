//
//  PTETChannelLabel.m
//  PeanutEntertainment
//
//  Created by zhouen on 16/9/7.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "ZNChannelLabel.h"

@implementation ZNChannelLabel

+ (instancetype)channelLabelWithTitle:(NSString *)title
{
    ZNChannelLabel *label = [self new];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    [label sizeToFit];
    label.userInteractionEnabled = YES;
    
    return label;
}

- (void)p_setLableColor {
    
    CGFloat red, green, blue, alpha;
    [self.selectedColor getRed:&red
                         green:&green
                          blue:&blue
                         alpha:&alpha];
    
    self.textColor = [UIColor colorWithRed:self.scale * red
                                     green:self.scale * green
                                      blue:self.scale * blue
                                     alpha:1];

}

- (CGFloat)textWidth
{
    return [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}].width + 10; // +8，要不太窄
}

- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    
    [self p_setLableColor];
}

- (void)setSelectedColor:(UIColor *)selectedColor {
    
    _selectedColor = selectedColor;
    
    [self p_setLableColor];
}

@end
