//
//  SettingCell.h
//  ReactiveCocoaDemo
//
//  Created by zhouen on 16/9/2.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MEItem;
@interface CustomSettingCell : UITableViewCell
@property (strong,nonatomic) MEItem *item;

+ (id)settingCellWithTableView:(UITableView *)tableView;
@end
