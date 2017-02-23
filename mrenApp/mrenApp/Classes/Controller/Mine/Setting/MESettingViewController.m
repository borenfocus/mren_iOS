//
//  MESettingViewController.m
//  mrenApp
//
//  Created by zhouen on 16/12/9.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MESettingViewController.h"
#import "MEAboutUsViewController.h"
#import "MESection.h"
#import "MEItem.h"

@interface MESettingViewController ()

@end

@implementation MESettingViewController

#pragma mark ------ Lifecycle

- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_initData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"设置";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ------ setter getter


#pragma mark ------ Public


#pragma mark ------ Private
- (void)p_initData {
    self.sections = @[[self p_getSection1],
                      [self p_getSection2]];
}

- (MESection *)p_getSection1 {
    @weakify(self);
    MEItem *item1 = [MEItem itemWithText:@"推送消息" actionBlock:^{
        
    }];
    item1.accessoryType = ItemAccessoryTypeSwitch;
    item1.isOn = YES;
    
    MEItem *item2 = [MEItem itemWithText:@"给我们评分" actionBlock:^{
        @strongify(self);
        [self p_toAppStoreGraded];
    }];
    
    MEItem *item3 = [MEItem itemWithText:@"QQ交流群" actionBlock:^{
        
    }];
    item3.detailText = @"533421511";
    item3.accessoryType = ItemAccessoryTypeNone;
    
    
    MESection *section = [[MESection alloc] init];
    section.items = @[item1 ,item2 ,item3];
    section.headerHeight = 0.1f;
    return section;
}
- (MESection *)p_getSection2 {
    @weakify(self);
    MEItem *item1 = [MEItem itemWithText:@"关于我们" actionBlock:^{
        @strongify(self);
        [self.navigationController pushViewController:[MEAboutUsViewController new] animated:YES];
    }];
    
    
    MEItem *item2 = [MEItem itemWithText:@"退出" actionBlock:^{
        @strongify(self);
        [User clearGlobalUser];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    MESection *section = [[MESection alloc] init];
    section.items = @[item1 ,item2];
    return section;
}
- (MESection *)p_getSection3 {
    MEItem *item1 = [MEItem itemWithText:@"退出" actionBlock:^{
        
    }];
    MESection *section = [[MESection alloc] init];
    section.items = @[item1];
    section.footerHeight = 20;
    return section;
}

#pragma mark 去评分
- (void)p_toAppStoreGraded {
    NSString *str = [NSString stringWithFormat: @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", @"1191484225"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}



#pragma mark ------ Protocol
#pragma mark ------ UITextFieldDelegate
#pragma mark ------ UITableViewDataSource
#pragma mark ------ UITableViewDelegate
#pragma mark ------ UIScrollViewDelegate
#pragma mark ------ Override

@end
