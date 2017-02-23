//
//  ZFSettingCell.h
//  ZFSetting
//
//  Created by 任子丰 on 15/9/19.
//  Copyright (c) 2013年 任子丰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MEItem;
@interface SystemSettingCell : UITableViewCell
@property (nonatomic, strong) MEItem *item;
/** switch状态改变的block*/
@property (copy, nonatomic) void(^switchChangeBlock)(BOOL on);

+ (id)settingCellWithTableView:(UITableView *)tableView;
@end
