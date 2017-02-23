//
//  UIView+Extension.h
//  fate
//
//  Created by 周恩 on 15/11/1.
//  Copyright © 2015年 zhouen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
/*
 尺寸相关
 */
@property (assign, nonatomic) CGFloat left;
@property (assign, nonatomic) CGFloat top;

@property (assign, nonatomic) CGFloat bottom;
@property (assign, nonatomic) CGFloat right;

@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;

@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property (nonatomic) CGFloat centerX;

@property (nonatomic) CGFloat centerY;


/*
 添加单击手势
 */
- (void)addTapGestureWithTarget:(nullable id)target action:(nullable SEL)action;
@end
