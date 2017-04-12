//
//  CustomTabBar.m
//  tabbar
//
//  Created by zhouen on 13/2/20.
//  Copyright © 2013年 zn. All rights reserved.
//

#import "CustomTabBar.h"
@interface CustomTabBar ()
@property (nonatomic, strong) UIButton *centerBtn;
@end
@implementation CustomTabBar

- (UIButton *)centerBtn {
    if(!_centerBtn){
        _centerBtn = [[UIButton alloc]init];
        [_centerBtn setBackgroundImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
        _centerBtn.backgroundColor = [UIColor clearColor];
        [_centerBtn addTarget:self action:@selector(p_centerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _centerBtn;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = self.bounds.size.width/(self.items.count + 1);
    CGFloat btnH = self.bounds.size.height;
    
    int i = 0;
    for (UIView *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (i == (self.subviews.count -1)/2) {
                i = i + 1;
            }
            btnX = i * btnW;
            tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
            i ++;
        }
    }
    
    self.centerBtn.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - 15);
    self.centerBtn.bounds = CGRectMake(0, 0, 68, 54);
    [self addSubview:self.centerBtn];
    
    
    
}
- (void)p_centerBtnClick:(UIButton *)sender {
    if (_clickBlock) {
        _clickBlock();
    }
}
@end
