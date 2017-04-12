//
//  RootTabBarController.m
//  SystemTabBar
//
//  Created by zn on 15/12/4.
//  Copyright © 2015年 zn. All rights reserved.
//

#import "TabBarViewController.h"
#import "MEBaseNavigationController.h"
#import "MEHomeViewController.h"
#import "MEMineViewController.h"
#import "CustomTabBar.h"

@interface TabBarViewController ()<UITabBarControllerDelegate>

@end

#define kClassKey   @"rootVCClassString"
#define kTitleKey   @"title"
#define kImgKey     @"imageName"
#define kSelImgKey  @"selectedImageName"
#define kThemeColor [UIColor colorWithRed:0 green:(190 / 255.0) blue:(12 / 255.0) alpha:1]


@implementation TabBarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
#warning TODO YES/NO
    if (YES) {
        CustomTabBar *tabBar = [[CustomTabBar alloc]initWithFrame:self.tabBar.frame];
        [self setValue:tabBar forKeyPath:@"tabBar"];
        tabBar.clickBlock = ^(){
#warning TODO presentViewController
            [self presentViewController:[UIViewController new] animated:YES completion:nil];
            
        };
    }
    
    [self p_setupSubviews];
    
    //背景颜色
    [self.tabBar setBarTintColor:[UIColor whiteColor]];
    //取消tabBar的透明效果。
    self.tabBar.translucent = NO;
    
    //去处顶部分割线
    [self.tabBar setShadowImage:[UIImage new]];
    [self.tabBar setBackgroundImage:[UIImage new]];
    
    //阴影
//    self.tabBar.layer.shadowOpacity = 0.15;
    
    //改变tabbar 线条颜色
    CGRect rect = CGRectMake(0, 0, self.tabBar.frame.size.width, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,HEX_COLOR(0xf1f1f1).CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setShadowImage:img];
    [self.tabBar setBackgroundImage:[[UIImage alloc]init]];
    
}

- (void)p_setupSubviews {
    NSArray *childItemsArray = @[
                                 @{kClassKey  : @"MEHomeViewController",
                                   kTitleKey  : @"妹子",
                                   kImgKey    : @"tabbar_mainframe",
                                   kSelImgKey : @"tabbar_mainframeHL"},
                                 
                                 @{kClassKey  : @"MEMineViewController",
                                   kTitleKey  : @"我的",
                                   kImgKey    : @"tabbar_contacts",
                                   kSelImgKey : @"tabbar_contactsHL"}
                                 ];
    
    
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        UIViewController *vc = [NSClassFromString(dict[kClassKey]) new];
        vc.title = dict[kTitleKey];
        MEBaseNavigationController *nav = [[MEBaseNavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        item.title = dict[kTitleKey];
        item.image = [[UIImage imageNamed:dict[kImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [[UIImage imageNamed:dict[kSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //title间距
        item.titlePositionAdjustment = UIOffsetMake(0, -2);
        item.imageInsets = UIEdgeInsetsMake(-2, 0, 2, 0);
        
        //默认状态下文字颜色
        //        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : kThemeColor} forState:UIControlStateNormal];
        //选中状态下文字颜色
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : kThemeColor} forState:UIControlStateSelected];
        [self addChildViewController:nav];
    }];
    self.selectedIndex = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
