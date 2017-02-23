//
//  NSString+CGFloat.h
//  69Show
//
//  Created by zn on 16/6/21.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CGFloat)

+ (CGFloat)getHeightWithContent:(NSString *)content width:(CGFloat)width font:(CGFloat)font;

+ (CGFloat)getWidthWithContent:(NSString *)content height:(CGFloat)height font:(CGFloat)font;

+ (CGRect)getRectWithContent:(NSString *)content font:(CGFloat)font;
@end
