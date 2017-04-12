//
//  UIView+HUD.m
//  mrenApp
//
//  Created by zhouen on 2017/3/24.
//  Copyright © 2017年 zhouen. All rights reserved.
//

#import "UIView+HUD.h"

static const void *kHudView = @"k_HudView";
static const void *kHudLabel = @"kHudLabel";
static const void *kHudImageView = @"kHudImageView";

static const void *kTapBlock = @"k_TapBlock";
static const void *kProTapG = @"k_Pro_TapG";
static const void *kCState = @"k_current_State";

@interface UIView ()

@property (nonatomic, strong) UIView *hudView;
@property (nonatomic, strong) UILabel *hudLabel;
@property (nonatomic, strong) FLAnimatedImageView  *hudImageView;
@property (nonatomic, assign) NSNumber *currentHudState;

@end
@implementation UIView (HUD)

- (UIView *)hudView {
    UIView *hudView = objc_getAssociatedObject(self, &kHudView);
    if (!hudView) {
        CGSize size = CGSizeMake(300, 100);
        CGRect rect = rect = CGRectMake(self.center.x - size.width/2.0, self.center.y - size.height/2.0, size.width , size.height);;
        hudView = [[UIView alloc] initWithFrame:rect];
        [self addSubview:hudView];
        [self bringSubviewToFront:hudView];
        hudView.hidden = YES;
        hudView.userInteractionEnabled = YES;
        objc_setAssociatedObject(self, &kHudView, hudView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        //imageView
        CGSize imageViewSize = CGSizeMake(80, 80);
        CGFloat ix = (size.width - imageViewSize.width) / 2.0;
        FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
        imageView.size = imageViewSize;
        imageView.origin = CGPointMake(ix, 0);
        [hudView addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        objc_setAssociatedObject(self, &kHudImageView, imageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        //label
        UILabel *hudLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageViewSize.height, hudView.width, 20)];
        hudLabel.font = [UIFont systemFontOfSize:14];
        hudLabel.textAlignment = NSTextAlignmentCenter;
        [hudView addSubview:hudLabel];
        objc_setAssociatedObject(self, &kHudLabel, hudLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return hudView;
}

- (UILabel *)hudLabel {
    return objc_getAssociatedObject(self, &kHudLabel);
}

- (FLAnimatedImageView *)hudImageView {
    return objc_getAssociatedObject(self, &kHudImageView);
}

- (void)showState:(HudState)hudState tapBlock:(tapBlock)block {
    [self showStatus:hudState text:nil imageName:nil tapBlock:block];
}

- (void)setCurrentHudState:(NSNumber *)currentHudState {
    objc_setAssociatedObject(self, &kCState, currentHudState, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)currentHudState {
    return  objc_getAssociatedObject(self, &kCState);
}


- (void)showStatus:(HudState)hudState text:(NSString *)text imageName:(NSString *)imageName tapBlock:(tapBlock)block {
    if (!IS_NET) {
        text = @"没有网络哟～先去检查网络吧...";
        imageName = @"loading_error";
        hudState = HudStateNetBreak;
    }
    if ([self.currentHudState integerValue]== hudState) {
        return;
    }
    
    [self show];
    
    if (IS_NET) {
        switch (hudState) {
            case HudStateLoading:
                text = text ? text : @"拼命加载中...";
                imageName = imageName ? imageName : @"loading_normal.gif";
                break;
            case HudStateError:
                text = text ? text : @"加载数据异常，点击重试";
                imageName = imageName ? imageName : @"loading_error.png";
                break;
            case HudStateNoData:
                text = text ? text : @"呀！空数据啦";
                imageName = imageName ? imageName : @"loading_noData.png";
                break;
            default:
                text = text ? text : @"拼命加载中...";
                imageName = imageName ? imageName : @"loading_normal.gif";
                break;
        }
        
    }
    
    self.currentHudState = @(hudState);
    [self changeStatus:text imageName:imageName tapBlock:block];
    
}



/* 改变文字及图片 */
- (void)changeStatus:text imageName:imageName tapBlock:(tapBlock)block{
    
    self.hudLabel.text = text;
    NSString *imageStr = [imageName lowercaseString];
    if ([imageStr rangeOfString:@"gif"].location != NSNotFound) {
        NSURL *localUrl = [[NSBundle mainBundle] URLForResource:imageName withExtension:nil];
        NSData *data = [NSData dataWithContentsOfURL:localUrl];
        FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:data];
        self.hudImageView.animatedImage = animatedImage;
    } else {
        [self.hudImageView setImage:[UIImage imageNamed:imageName]];
    }
    
    if (block) {
        objc_setAssociatedObject(self, &kTapBlock, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    // 添加手势
    [self addTapGesture];
}

/* 添加点击手势 */
- (void)addTapGesture {
    // 添加手势
    [self.hudView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBlock)]];
    
}

#pragma mark - 回调  Click return
- (void)tapBlock {
    tapBlock block = objc_getAssociatedObject(self, &kTapBlock);
    if (block) {
        block();
    }
}

#pragma mark - 显示 Tips show
- (void)show {
    self.hudView.hidden = NO;
    
//    [self addSubview:self.hudView];
    
}

#pragma mark - 消失 Tips hide
- (void)hideHud {
    UIView *hudView = objc_getAssociatedObject(self, &kHudView);
    if (hudView) {
        hudView.hidden = YES;
//        [self.hudView removeFromSuperview];
    }
    
}


@end
