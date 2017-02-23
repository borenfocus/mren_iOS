//
//  ZFSettingself.m
//  ZFSetting
//
//  Created by 任子丰 on 15/9/19.
//  Copyright (c) 2013年 任子丰. All rights reserved.
//

#import "SystemSettingCell.h"
#import "MEItem.h"

@interface SystemSettingCell()
@property (nonatomic, strong) UISwitch *switchBtn;
@end

@implementation SystemSettingCell

+ (id)settingCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"SystemSettingCell";
    SystemSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[SystemSettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setItem:(MEItem *)item
{
    _item = item;
    
    // 设置数据
    self.imageView.image = item.image;
    self.textLabel.text = item.text;
    self.detailTextLabel.text = item.detailText;
    
    if (item.accessoryType == ItemAccessoryTypeDisclosureIndicator) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        // 用默认的选中样式
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        
    } else if (item.accessoryType == ItemAccessoryTypeSwitch) {
        
        if (!_switchBtn) {
            _switchBtn = [[UISwitch alloc] init];
            [_switchBtn setOn:_item.isOn];
            [_switchBtn addTarget:self action:@selector(switchStatusChanged:) forControlEvents:UIControlEventValueChanged];
        }
        
        // 右边显示开关
        self.accessoryView = _switchBtn;
        // 禁止选中
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    } else if (item.accessoryType == ItemAccessoryTypeCustomView){
        //不处理自定义的
        
    } else {
        self.accessoryView = nil;
        // 用默认的选中样式
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
}

#pragma mark - SwitchValueChanged

- (void)switchStatusChanged:(UISwitch *)sender
{
    if (self.switchChangeBlock) {
        self.switchChangeBlock(sender.on);
    }
}
@end
