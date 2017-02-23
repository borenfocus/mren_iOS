//
//  MEBaseSettingViewController.h
//  mrenApp
//
//  Created by zhouen on 16/12/9.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SettingCellType) {
    SettingCellTypeDefault,
    SettingCellTypeCustom
};

@interface MEBaseSettingViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>
//@property (nonatomic, strong)   UITableView *tableView;
@property (nonatomic, strong)   NSArray *sections;
@property (nonatomic, assign)   SettingCellType cellType;
@end
