//
//  UIViewController+HUD.h
//  mrenApp
//
//  Created by zhouen on 16/12/30.
//  Copyright © 2016年 zhouen. All rights reserved.
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

typedef enum {
    LoadingImageTypeNormal = 0,
    LoadingImageTypeGIF
}LoadingImageType;

//点击主屏幕回调
typedef void(^tapBlock)();

@interface UIViewController (HUD)

/// 显示状态，点击屏幕时回调。显示文字
- (void)showStatus:(NSString *)status tapBlock:(tapBlock)block;

/// 显示状态，点击屏幕时回调，如果是gif，type请填gif, 默认加载jpg,png。
- (void)showStatus:(NSString *)status imageName:(NSString *)imageName type:(LoadingImageType)type tapBlock:(tapBlock)block;


- (void)showHudWithState:(HudState)hudState tapBlock:(tapBlock)block;

/// 隐藏提示
- (void)hideHud;
@end
