//
//  SettingCell.m
//  ReactiveCocoaDemo
//
//  Created by zhouen on 16/9/2.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "CustomSettingCell.h"
#import "MEItem.h"
#import <ReactiveCocoa.h>
@interface CustomSettingCell ()
@property (strong,nonatomic) UIImageView *detailImage;
@property (strong,nonatomic) UILabel *detailTextLabel;

@property (strong,nonatomic) UISwitch *switchView;
@end

@implementation CustomSettingCell
@synthesize detailTextLabel = _detailTextLabel;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        self.detailImage = [[UIImageView alloc] init];
        _detailImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_detailImage];
        
        self.detailTextLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.detailTextLabel];
        
        self.switchView = [UISwitch new];
        
         [_switchView addTarget:self action:@selector(swithChanged:) forControlEvents:UIControlEventValueChanged];
        
    }
    return self;
}

+ (id)settingCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"CustomSettingCell";
    CustomSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[CustomSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(void)setItem:(MEItem *)item{
    _item = item;
    self.imageView.image = item.image?:nil;
    self.textLabel.text = item.text?:nil;
    
    [self setupAccessoryType];
    
    if (item.detailText) {
        [self setupDetailText];
    }
    
    if (item.detailImage || item.detailImageUrl) {
        [self setupDetailImage];
    }
    
    //35 16  ,38  20
    
}

-(void)setupAccessoryType{
    if (self.item.accessoryType == ItemAccessoryTypeSwitch) {
        self.accessoryView = _switchView;
        [_switchView setOn:_item.isOn];
    }else if (self.item.accessoryType == ItemAccessoryTypeCustomView){
        self.accessoryView = _item.customView;
    }else{
        self.accessoryView = nil;
        self.accessoryType = (UITableViewCellAccessoryType)self.item.accessoryType;
    }
}

-(void)setupDetailText{
    CGFloat width = self.accessoryView.frame.size.width + 14 + 13;
    self.detailImage.image = nil;
    self.detailTextLabel.text = _item.detailText;
    
    @weakify(self);
    if (self.item.accessoryType == ItemAccessoryTypeNone) {
        width = 16;
        [_detailTextLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.right.equalTo(self.mas_right).with.offset(-width);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
        }];
    }else if(self.item.accessoryType == ItemAccessoryTypeDisclosureIndicator){
        width = 35;
        [_detailTextLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.right.equalTo(self.mas_right).with.offset(-width);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
    }else{
        [_detailTextLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.right.equalTo(self.mas_right).with.offset(-width);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
        }];
    }
}

-(void)setupDetailImage{
    CGFloat width = self.accessoryView.frame.size.width + 14 + 13;
    self.detailTextLabel.text = nil;
    if (_item.detailImageUrl) {
        [self.detailImage sd_setImageWithURL:[NSURL URLWithString:_item.detailImageUrl] placeholderImage:[UIImage imageNamed:@"header_default"]];
    } else {
        self.detailImage.image = _item.detailImage;
    }
    self.detailImage.frame = CGRectMake(0, 0, 60, 60);
    self.accessoryView = self.detailImage;
    self.detailImage.layer.cornerRadius = 30;
    self.detailImage.layer.masksToBounds = YES;
    return;
    
    CGFloat offset = 6;
    @weakify(self);
    if (self.item.accessoryType == ItemAccessoryTypeNone) {
        width = 16;
        [_detailImage mas_remakeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.right.equalTo(self.mas_right).with.offset(-width);
            make.top.equalTo(self.mas_top).with.offset(offset);
            make.bottom.equalTo(self.mas_bottom).with.offset(-offset);
            make.width.mas_equalTo(self.height - 2*offset);
        }];
    }else if(self.item.accessoryType == ItemAccessoryTypeDisclosureIndicator){
        width = 35;
        [_detailImage mas_remakeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.right.equalTo(self.mas_right).with.offset(-width);
            make.top.equalTo(self.mas_top).with.offset(offset);
            make.bottom.equalTo(self.mas_bottom).with.offset(-offset);
            make.width.mas_equalTo(self.height - 2*offset);
        }];
        
    }else{
        [_detailImage mas_remakeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.right.equalTo(self.mas_right).with.offset(-width);
            make.top.equalTo(self.mas_top).with.offset(offset);
            make.bottom.equalTo(self.mas_bottom).with.offset(-offset);
            make.width.mas_equalTo(self.height - 2*offset);
        }];
    }
}

-(void)swithChanged:(UISwitch *)sender{
    if (_item.switchValueChanged) {
        _item.switchValueChanged(sender.isOn);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
