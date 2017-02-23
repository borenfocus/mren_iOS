//
//  MEUpdateInfoView.m
//  mrenApp
//
//  Created by zhouen on 16/12/19.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MEUpdateInfoView.h"

@implementation MEUpdateInfoView
- (instancetype)initWithMessage:(NSString *)message
{
    self = [super init];
    if (self) {
        //数据库里直接有\n不换行
        message = [message stringByReplacingOccurrencesOfString:@"//n" withString:@"\n"];
        float textWidth = 260;
        
        float textMargin = 10;
        
        UILabel *titleLabel = [[UILabel alloc]init];
        
        titleLabel.font = [UIFont systemFontOfSize:18];
        
        titleLabel.textColor = [UIColor blackColor];
        
        titleLabel.backgroundColor = [UIColor clearColor];
        
        titleLabel.lineBreakMode =NSLineBreakByWordWrapping;
        
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        titleLabel.text = @"新版本检查";
        
        titleLabel.frame = CGRectMake(0, textMargin, textMargin * 2 + textWidth, 40);
        
        UIFont *textFont = [UIFont systemFontOfSize:15];
        
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        
        attrs[NSFontAttributeName] = textFont;
        
        CGSize maxSize = CGSizeMake(textWidth-textMargin*2, MAXFLOAT);
        
        CGSize size = [message boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(textMargin,CGRectGetMaxY(titleLabel.frame) + textMargin,textWidth, size.height)];
        
        textLabel.font = textFont;
        
        textLabel.textColor = [UIColor blackColor];
        
        textLabel.backgroundColor = [UIColor clearColor];
        
        textLabel.lineBreakMode =NSLineBreakByWordWrapping;
        
        textLabel.numberOfLines =0;
        
        textLabel.textAlignment =NSTextAlignmentLeft;
        
        textLabel.text = message;
        
        self.frame = CGRectMake(0, 0, textWidth + textMargin * 2,CGRectGetMaxY(textLabel.frame)+textMargin);
        
        [self addSubview:titleLabel];
        
        [self addSubview:textLabel];
    }
    return self;
}
+ (instancetype)updateViewWithMessage:(NSString *)message {
    return [[MEUpdateInfoView alloc] initWithMessage:message];
}

@end
