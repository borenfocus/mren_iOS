//
//  PTETChannelLabel.h
//  PeanutEntertainment
//
//  Created by zhouen on 16/9/7.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZNChannelLabel : UILabel

@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGFloat textWidth;
@property (nonatomic, strong) UIColor *selectedColor;

+ (instancetype)channelLabelWithTitle:(NSString *)title;

@end
