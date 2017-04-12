//
//  UIView+HUD.h
//  mrenApp
//
//  Created by zhouen on 2017/3/24.
//  Copyright © 2017年 zhouen. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  无数据时页面提示，支持图片，文字，gif 显示
 */

typedef enum {
    HudStateLoading = 1,
    HudStateNoData,
    HudStateError,
    HudStateNetBreak
}HudState;


//点击主屏幕回调
typedef void(^tapBlock)();

@interface UIView (HUD)
/**
 显示 加载、异常、空数据、没有网络状态
 
 @param hudState    ---状态标示
 @param text        ---状态描述  if nil to user default
 @param imageName   ---状态图图片名称 需要带有图片后缀例 XXX.png（仅仅支持本地）if nil to user default
 @param block       ---回调
 */
- (void)showStatus:(HudState)hudState
              text:(NSString *)text
         imageName:(NSString *)imageName
          tapBlock:(tapBlock)block;


- (void)showState:(HudState)hudState
         tapBlock:(tapBlock)block;

- (void)hideHud;
@end
