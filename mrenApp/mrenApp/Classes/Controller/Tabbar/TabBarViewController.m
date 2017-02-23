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

@interface TabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.tabBar.tintColor = THEME_COLOR;
    //初始化所有子控件
    [self setupAllChildViewController];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//初始化所有控制器
-(void)setupAllChildViewController{
    MEHomeViewController *home=[[MEHomeViewController alloc] init];
    [self setupChildViewController:home title:@"首页" imageName:@"tabbar_MM" selectedImage:@"tabbar_MM_sel"];
    
    
    MEMineViewController *mine=[[MEMineViewController alloc] init];
    [self setupChildViewController:mine title:@"我的" imageName:@"tabbar_mine" selectedImage:@"tabbar_mine_sel"];
    
}

//设置控制器一些--
- (void)setupChildViewController:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName selectedImage:(NSString *)selectedImage{
//    childVC.title=title;
    childVC.tabBarItem.image=[UIImage imageNamed:imageName];
    childVC.tabBarItem.imageInsets=UIEdgeInsetsMake(6, 0,-6, 0);
    
    UIImage *selImage=[UIImage imageNamed:selectedImage];
    childVC.tabBarItem.selectedImage=[selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    MEBaseNavigationController *nav=[[MEBaseNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:childVC];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
//    [viewController viewWillAppear:NO];
    self.navigationItem.title = @"";
}



@end
