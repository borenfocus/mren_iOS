//
//  MEBaseSettingViewController.m
//  mrenApp
//
//  Created by zhouen on 16/12/9.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MEBaseSettingViewController.h"
#import "SystemSettingCell.h"
#import "CustomSettingCell.h"
#import "MEItem.h"
#import "MESection.h"
@interface MEBaseSettingViewController ()

@end

@implementation MEBaseSettingViewController

//- (void)loadView
//{
//    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStyleGrouped];
//    _tableView.separatorColor = [UIColor colorWithWhite:0.4 alpha:0.3];
//    _tableView.backgroundColor = [UIColor clearColor];
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    self.view = _tableView;
//}

-(instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
}
#pragma mark ------ Lifecycle
- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MAIN_COLOR;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ------ setter getter


#pragma mark ------ Public


#pragma mark ------ Private



#pragma mark ------ Protocol
#pragma mark ------ UITextFieldDelegate
#pragma mark ------ UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MESection *sectionModel = self.sections[section];
    return sectionModel.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MESection *sectionModel = self.sections[indexPath.section];
    MEItem *item = sectionModel.items[indexPath.row];
    if (self.cellType == SettingCellTypeDefault) {
        SystemSettingCell *cell = [SystemSettingCell settingCellWithTableView:tableView];
        cell.item = item;
        return cell;
    } else {
        CustomSettingCell *cell = [CustomSettingCell settingCellWithTableView:tableView];
        cell.item = item;
        return cell;
    }
}



#pragma mark ------ UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    MESection *sectionModel = self.sections[section];
    return sectionModel.headerHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    MESection *sectionModel = self.sections[section];
    return sectionModel.footerHeight;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    MESection *sectionModel = self.sections[section];
    return sectionModel.headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    MESection *sectionModel = self.sections[section];
    return sectionModel.footerTitle;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MESection *sectionModel = self.sections[indexPath.section];
    MEItem *item = sectionModel.items[indexPath.item];
    if (item.execute) {
        item.execute();
    }
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,10,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,10,0,0)];
    }
}
@end
