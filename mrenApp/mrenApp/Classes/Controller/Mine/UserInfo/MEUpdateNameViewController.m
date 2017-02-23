//
//  LKUpdateNameViewController.m
//  vchat
//
//  Created by zhouen on 16/8/17.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MEUpdateNameViewController.h"
#import "MEUpdateViewModel.h"
#import "MEUser.h"

@interface MEUpdateNameViewController ()
@property (strong,nonatomic) MEUpdateViewModel *updateViewModel;
@property (weak,nonatomic) UITextField *nickNameField;
@property (nonatomic, strong) MEUser *user;
@end
@implementation MEUpdateNameViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    _updateViewModel = [[MEUpdateViewModel alloc] init];
    [self setupNav];
    [self setupSubview];
}

-(void)setupSubview{
    
    self.view.backgroundColor = MAIN_COLOR;
   
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 84, self.view.width, 40)];
    textField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:textField];
    textField.font = [UIFont systemFontOfSize:14];
    textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 12, textField.height)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.backgroundColor = [UIColor whiteColor];
//    textField.tintColor = kLuckThemeColor;
    textField.text = [MEUser userDefaults].nickname;
    self.nickNameField = textField;
    
    RAC(_updateViewModel,nickName) = self.nickNameField.rac_textSignal;
    
    @weakify(self);
    [[_updateViewModel.saveCommand executionSignals] subscribeNext:^(id x) {
        [x subscribeNext:^(NSString  *x) {
            @strongify(self);
            if ([x isEqualToString:([MEUser userDefaults].nickname)]){
                [self.view makeCenterToast:@"昵称尚未修改"];
            } else{
                if (_saveBlock) {
                    _saveBlock(x);
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }];
}

- (void)setupNav{
    self.title = @"修改资料";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.rightBarButtonItem.rac_command = _updateViewModel.saveCommand;
}

-(void)didClickedSave:(id)sender{
    NSString *nickName = [_nickNameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([nickName isEqualToString:([MEUser userDefaults].nickname)]){
        [self.view makeCenterToast:@"昵称尚未修改"];
        return;
    }
    if (_saveBlock) {
        _saveBlock(nickName);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)didClickedBackBtn:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
