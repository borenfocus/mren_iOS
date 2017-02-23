//
//  NSString+CGFloat.m
//  69Show
//
//  Created by zn on 16/6/21.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "NSString+CGFloat.h"

@implementation NSString (CGFloat)
//根据宽度求高度  content 计算的内容  width 计算的宽度 font字体大小
+ (CGFloat)getHeightWithContent:(NSString *)content width:(CGFloat)width font:(CGFloat)font{
    
    CGRect rect = [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                        context:nil];
    return rect.size.height;
}

//根据高度度求宽度  content 计算的内容  Height 计算的高度 font字体大小
+ (CGFloat)getWidthWithContent:(NSString *)content height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [content boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                        context:nil];
    return rect.size.width;
}

//根据高度度求宽度  content 计算的内容  Height 计算的高度 font字体大小
+ (CGRect)getRectWithContent:(NSString *)content font:(CGFloat)font{
    
    CGRect rect = [content boundingRectWithSize:CGSizeMake(1000, 1000)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                        context:nil];
    return rect;
}

@end
