//
//  UIViewController+HUD.m
//  mrenApp
//
//  Created by zhouen on 16/12/30.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "UIViewController+HUD.h"

#import <objc/message.h>
#import "UIImage+Gif.h"

static const void *kHud = @"k_labelHud";
static const void *kHudImageView = @"k_ImageViewHud";
static const void *kTapG = @"k_TapG";
static const void *kProTapG = @"k_Pro_TapG";
static const void *kCState = @"k_current_State";

@interface UIViewController ()

@property (nonatomic,strong)UILabel *labelHud;
@property (nonatomic, strong) FLAnimatedImageView  *hudImageView;
@property (nonatomic,strong)UITapGestureRecognizer *tapGestureBlock;

@property (nonatomic, assign) NSNumber *currentHudState;

@end

@implementation UIViewController (HUD)


- (void)setTapGestureBlock:(UITapGestureRecognizer *)tapGestureBlock {
    objc_setAssociatedObject(self, &kProTapG, tapGestureBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (UITapGestureRecognizer *)tapGestureBlock {
    return  objc_getAssociatedObject(self, &kProTapG);
}

- (void)setCurrentHudState:(NSNumber *)currentHudState {
    objc_setAssociatedObject(self, &kCState, currentHudState, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)currentHudState {
    return  objc_getAssociatedObject(self, &kCState);
}

- (UILabel *)labelHud {
    UILabel *subhud = objc_getAssociatedObject(self, &kHud);
    if (subhud == nil) {
        subhud = [[UILabel alloc]initWithFrame:CGRectMake(20, self.view.center.y, self.view.frame.size.width - 40, 30)];
        subhud.font = [UIFont systemFontOfSize:14];
        subhud.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:subhud];
        
        objc_setAssociatedObject(self, &kHud, subhud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return subhud;
}

- (void)setLabelHud:(UILabel *)labelHud {
    objc_setAssociatedObject(self, &kHud, labelHud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (FLAnimatedImageView *)hudImageView {
    FLAnimatedImageView *imageView = objc_getAssociatedObject(self, &kHudImageView);
    if (!imageView) {
        imageView = [[FLAnimatedImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 100) / 2, self.view.center.y - 100, 100, 100)];
        objc_setAssociatedObject(self, &kHudImageView, imageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return imageView;
}

- (void)setHudImageView:(FLAnimatedImageView *)hudImageView {
    objc_setAssociatedObject(self, &kHudImageView, hudImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark更改状态
- (void)showHudWithState:(HudState)hudState tapBlock:(tapBlock)block {
    if (!IS_NET) {
        if ([self.currentHudState integerValue] == HudStateNetBreak) return;
        [self showStatus:@"没有网络哟～先去检查网络吧..." imageName:@"mm_arse" type:LoadingImageTypeGIF tapBlock:^{
            if (block) {
                block();
            }
        }];
        self.currentHudState = @(HudStateNetBreak);
    }
    if (hudState == HudStateLoading) {
        if ([self.currentHudState integerValue] == HudStateLoading) return;
        NSString *gifName = @"mm_arse";
        if (AppVersion.appState == AppStateOnline) {
            gifName = @"loading_normal";
        }
        [self showStatus:@"扭摆加载中..." imageName:gifName type:LoadingImageTypeGIF tapBlock:^{
            if (block) {
                block();
            }
        }];
        self.currentHudState = @(HudStateLoading);
    } else if (hudState == HudStateError) {
        if ([self.currentHudState integerValue] == HudStateError) return;
        [self showStatus:@"加载数据异常，点击重试" imageName:@"loading_error" type:LoadingImageTypeNormal tapBlock:^{
            if (block) {
                block();
            }
        }];
        self.currentHudState = @(HudStateError);
    } else if (hudState == HudStateNoData) {
        if ([self.currentHudState integerValue] == HudStateNoData) return;
        [self showStatus:@"没有找到妹子哟" imageName:@"loading_noData" type:LoadingImageTypeNormal tapBlock:^{
            if (block) {
                block();
            }
        }];
        self.currentHudState = @(HudStateNoData);
    } else {
        [self showStatus:@"扭摆加载中..." imageName:@"mm_arse" type:LoadingImageTypeGIF tapBlock:^{
            if (block) {
                block();
            }
        }];
    }
}

#pragma mark - 显示状态
- (void)showStatus:(NSString *)status tapBlock:(tapBlock)block {
    [self changeStatus:status imageName:nil type:0 tapBlock:block];
}

#pragma mark - 显示状态以及显示没有数据时的图片
- (void)showStatus:(NSString *)status imageName:(NSString *)imageName type:(LoadingImageType)type tapBlock:(tapBlock)block {
    [self changeStatus:status imageName:imageName type:type tapBlock:block];
}

/* 改变文字及图片 */
- (void)changeStatus:(NSString *)status imageName:(NSString *)imageName type:(LoadingImageType)type tapBlock:(tapBlock)block{
    
    if (status) {
        self.labelHud.text = status;
    }
    if (imageName) {
        
        if (type == LoadingImageTypeGIF) {
            NSURL *localUrl = [[NSBundle mainBundle] URLForResource:imageName withExtension:@"gif"];
            NSData *data = [NSData dataWithContentsOfURL:localUrl];
            FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:data];
            self.hudImageView.animatedImage = animatedImage;
            self.hudImageView.userInteractionEnabled = YES;
        } else {
            
            [self.hudImageView setImage:[UIImage imageNamed:imageName]];
        }
        [self.view addSubview:self.hudImageView];
    }
    
    if (block) {
        
        objc_setAssociatedObject(self, &kTapG, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    // 添加手势
    [self addTapGesture];
}

/* 添加点击手势 */
- (void)addTapGesture {
    
    if (self.tapGestureBlock) {
        [self show];
        return;
    }
    // 添加全屏手势
    self.tapGestureBlock = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBlock)];
    [self.hudImageView addGestureRecognizer:self.tapGestureBlock];
}

#pragma mark - 回调  Click return
- (void)tapBlock {
    tapBlock block = objc_getAssociatedObject(self, &kTapG);
    if (block) {
        block();
    }
}

#pragma mark - 显示 Tips show
- (void)show {
    
    self.labelHud.hidden = NO;
    self.hudImageView.hidden = NO;
    [self.hudImageView addGestureRecognizer: self.tapGestureBlock];
    
}

#pragma mark - 消失 Tips hide
- (void)hideHud {
    
    if (self.labelHud) {
        /* 动画
         __weak typeof(self) __weakSelf = self;
         [UIView animateWithDuration:1 animations:^{
         __weakSelf.labelHud.alpha = 0;
         } completion:^(BOOL finished) {
         [__weakSelf.labelHud removeFromSuperview];
         }];
         */
        
        self.labelHud.hidden = YES;
    }
    
    self.hudImageView.hidden = YES;
    [self.hudImageView removeGestureRecognizer: self.tapGestureBlock];
}
@end
