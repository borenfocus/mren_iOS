//
//  LKUpdateSexSheet.m
//  VChat
//
//  Created by zhouen on 16/8/31.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MEUpdateSexSheet.h"
#import "UIImage+Extension.h"
@interface MEUpdateSexSheet ()
@property (weak,nonatomic) UIView *sheetView;
@property (strong,nonatomic) UIButton *manBtn;
@property (weak,nonatomic) UIButton *womBtn;
@property (weak,nonatomic) UIButton *manRightImage;
@property (weak,nonatomic) UIButton *womRightImage;
@end
@implementation MEUpdateSexSheet
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self addTapGestureWithTarget:self  action:@selector(didTapCover:)];
        [self setupSubview];
    }
    return self;
}

-(void)setupSubview{
    UIView *sheet = [[NSBundle mainBundle]loadNibNamed:@"MEUpdateSexSheet" owner:nil options:nil].lastObject;
    [sheet addTapGestureWithTarget:self  action:@selector(didTapCover:)];
    sheet.userInteractionEnabled = YES;
    sheet.tag = 1111;
    CGFloat sh = 156;
    CGFloat sx = 20;
    CGFloat sw = (self.width - 2*sx);
    CGFloat sy = (self.height - sh)/2.0;
    sheet.frame = CGRectMake(sx, sy, sw, sh);
    
    [self addSubview:sheet];
    self.sheetView = sheet;
    sheet.layer.cornerRadius = 4.0;
    sheet.layer.masksToBounds = YES;
    
    self.manBtn = [sheet viewWithTag:101];
    self.womBtn = [sheet viewWithTag:102];
    self.manRightImage = [sheet viewWithTag:201];
    self.womRightImage = [sheet viewWithTag:202];
    
    [_manRightImage setImage:[UIImage imageNamed:@"sex_mouse"] forState:UIControlStateSelected];
    [_womRightImage setImage:[UIImage imageNamed:@"sex_mouse"] forState:UIControlStateSelected];
    
    
    [_manBtn addTarget:self action:@selector(didSelectItem:) forControlEvents:UIControlEventTouchUpInside];
    
    [_manBtn setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];
    
    [_womBtn addTarget:self action:@selector(didSelectItem:) forControlEvents:UIControlEventTouchUpInside];
    [_womBtn setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];
    
}

-(void)didSelectItem:(UIButton *)btn{
    int sex = btn.tag == 101?0:1;
    [self changeSex:sex];
    if (_sexBlock) {
        _sexBlock(sex);
    }
    [self removeFromSuperview];
}

-(void)setSex:(NSString *)sex{
    _sex = sex;
    if ([_sex isEqualToString:@"男"]) {
        _manRightImage.selected = YES;
        _womRightImage.selected = NO;
    }else{
        _manRightImage.selected = NO;
        _womRightImage.selected = YES;
    }
}

- (void)changeSex:(BOOL)isWoman{
    if (!isWoman) {
        _womRightImage.hidden = YES;
        _manRightImage.hidden = NO;
    }else{
        _womRightImage.hidden = NO;
        _manRightImage.hidden = YES;
    }
}

-(void)didTapCover:(UITapGestureRecognizer*)recognizer{
    if (recognizer.view.tag == 1111) {
        return;
    }
    [self removeFromSuperview];
}
@end
