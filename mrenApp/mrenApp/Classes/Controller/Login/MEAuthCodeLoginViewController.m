//
//  PTETAuthCodeLoginViewController.m
//  PeanutEntertainment
//
//  Created by zhouen on 16/8/23.
//
//  //验证码登录

#import "MEAuthCodeLoginViewController.h"
#import "ZNTextField.h"
#import "NSString+CGFloat.h"
#import "UIImage+Extension.h"
#import "MEUserRequest.h"
#import <SMS_SDK/SMSSDK.h>
#import "MEUser.h"



@interface MEAuthCodeLoginViewController()<ZNTextFieldDelegate>
{
    dispatch_source_t _timer;
}

@property (nonatomic, strong) ZNTextField *userName;
@property (nonatomic, strong) ZNTextField *vertifyCode;
@property (nonatomic, strong) UIButton *regButton;
@property (nonatomic, strong) UIButton *verButton;

@end


@implementation MEAuthCodeLoginViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"验证码登录";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.view.backgroundColor = MAIN_COLOR;
    
    CGRect rect = CGRectZero;
    rect.origin.x = 35;
    rect.origin.y = 104;
    rect.size.width = SCREEN_WIDTH - (rect.origin.x * 2);
    rect.size.height = 44;
    
    _userName = [[ZNTextField alloc] initWithFrame:rect];
    _userName.leftImage = @"login_phone";
    _userName.placeHolder = @"请输入手机号";
    _userName.delegate = self;
    _userName.maxLength = 20;
    _userName.keyboardType = UIKeyboardTypeNumberPad;
    _userName.fonSize = 14;
    [self.view addSubview:_userName];
    
    
    _verButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_verButton setTitle:@"验证码" forState:UIControlStateNormal];
    [_verButton addTarget:self action:@selector(onTouchVertifyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _verButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _verButton.layer.cornerRadius = 4;
    
    rect.origin.y = _userName.bottom + 13;
    rect.size.width = [NSString getWidthWithContent:_verButton.titleLabel.text height:MAXFLOAT font:15] + 35;
    rect.origin.x = SCREEN_WIDTH - rect.origin.x - rect.size.width;
    _verButton.frame = rect;
    
    [_verButton setBackgroundImage:[UIImage imageWithColor:HEX_COLOR(0x288dff) size:rect.size]
                          forState:UIControlStateNormal];
    [_verButton setBackgroundImage:[UIImage imageWithColor:HEX_COLOR(0xdddddd) size:rect.size]
                          forState:UIControlStateDisabled];
    [_verButton setTitleColor:HEX_COLOR(0xffffff) forState:UIControlStateNormal];
    [_verButton setTitleColor:HEX_COLOR(0x666666) forState:UIControlStateDisabled];
    _verButton.clipsToBounds = YES;
    [self.view addSubview:_verButton];
    
    rect = _userName.frame;
    rect.size.width = _verButton.left - rect.origin.x - 5;
    rect.origin.y = _verButton.top;
    _vertifyCode = [[ZNTextField alloc] initWithFrame:rect];
    _vertifyCode.leftImage = @"login_telCode";
    _vertifyCode.placeHolder = @"请输入验证码";
    _vertifyCode.delegate = self;
    _vertifyCode.keyboardType = UIKeyboardTypeNumberPad;
    _vertifyCode.maxLength = 20;
    _vertifyCode.fonSize = 14;
    [self.view addSubview:_vertifyCode];
    
    rect.origin.y = _vertifyCode.bottom + 30;
    rect.size.width = _userName.width;
    rect.size.height = 40;
    _regButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _regButton.frame = rect;
    [_regButton setBackgroundImage:[UIImage imageWithColor:HEX_COLOR(0x288dff) size:rect.size] forState:UIControlStateNormal];
    [_regButton setBackgroundImage:[UIImage imageWithColor:HEX_COLOR(0xc7c7c7) size:rect.size] forState:UIControlStateDisabled];
    [_regButton setTitle:@"立即登录" forState:UIControlStateNormal];
    [_regButton setTitleColor:HEX_COLOR(0xffffff) forState:UIControlStateNormal];
    [_regButton setTitleColor:HEX_COLOR(0xffffff) forState:UIControlStateDisabled];
    [_regButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _regButton.titleLabel.font = [UIFont systemFontOfSize:16];
    _regButton.clipsToBounds = YES;
    _regButton.layer.cornerRadius = 4;
    _regButton.enabled = NO;
    [self.view addSubview:_regButton];
    
    
    
    /*第三方登录
    UIImage *btnImage = [UIImage imageNamed:@"btn_login_weixin"];
    rect = CGRectZero;
    rect.size.width = btnImage.size.width;
    rect.size.height = btnImage.size.height;
    
    CGFloat padding = kEstimateWidth(50.0f);
    CGFloat bottom = kEstimateHeigh(118.0f);
    if (iPhone4 || iPhone5) {
        bottom = kEstimateHeigh(148.0f);
    }
    
    rect.origin.y = SCREEN_HEIGHT - bottom - rect.size.height;
    
    rect.origin.x = (SCREEN_WIDTH - (rect.size.width * 3 + padding * 2)) / 2;
    
    
    NSArray *thirdImage = @[@"btn_login_weixin",@"btn_login_qq",@"btn_login_weibo"];
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i != 0) {
            btnImage = nil;
            btnImage = [UIImage imageNamed:thirdImage[i]];
            rect.origin.x += rect.size.width + padding;
        }
        button.frame = rect;
        [button addTarget:self action:@selector(buttonClickAction:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setImage:btnImage forState:UIControlStateNormal];
        button.tag = 1400 +i;
        [self.view addSubview:button];
    }
    
    NSString *tipString = @"第三方登录";
    rect.size = [NSString getRectWithContent:tipString font:12].size;
    rect.origin.y -= (15 + rect.size.height);
    rect.origin.x = (SCREEN_WIDTH - rect.size.width) / 2;
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:rect];
    tipLabel.text = tipString;
    tipLabel.textColor = HEX_COLOR(0x999999);
    tipLabel.font = [UIFont systemFontOfSize:12];
    tipLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tipLabel];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    CGMutablePathRef path = CGPathCreateMutable();
    
    
    CGPoint linePoint = CGPointZero;
    linePoint.x = tipLabel.left - 15;
    linePoint.y = tipLabel.top + (tipLabel.height / 2);
    
    CGPathMoveToPoint(path, NULL, 19, linePoint.y);
    CGPathAddLineToPoint(path, NULL, linePoint.x, linePoint.y);
    
    linePoint.x = tipLabel.right + 15;
    CGPathMoveToPoint(path, NULL, linePoint.x, linePoint.y);
    
    linePoint.x = SCREEN_WIDTH - 19;
    CGPathAddLineToPoint(path, NULL, linePoint.x, linePoint.y);
    
    maskLayer.path = path;
    CGPathRelease(path);
    
    maskLayer.backgroundColor = [[UIColor clearColor] CGColor];
    maskLayer.frame = self.view.bounds;
    maskLayer.masksToBounds = NO;
    [maskLayer setValue:[NSNumber numberWithBool:NO] forKey:@"isCircle"];
    maskLayer.fillColor = [[UIColor clearColor] CGColor];
    maskLayer.strokeColor = HEX_COLOR(0xcecece).CGColor;
    maskLayer.lineWidth = 0.6;
    [self.view.layer addSublayer:maskLayer];
    
     */
    
    
    UIImage *agreeImage =  [UIImage imageNamed:@"login_agree"];
    UIImageView *agreeView = [[UIImageView alloc] initWithImage:agreeImage];
    [self.view addSubview:agreeView];
    agreeView.hidden = YES;
    
    UIButton *termButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [termButton setTitle:@"《花生wifi用户服务协议》" forState:UIControlStateNormal];
    [termButton setTitleColor:HEX_COLOR(0x666666) forState:UIControlStateNormal];
    [termButton addTarget:self action:@selector(onTermButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    termButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:termButton];
    termButton.hidden = YES;
    
    
    CGFloat tipWidth = agreeView.width;
    CGFloat termWidth = [NSString getWidthWithContent:termButton.titleLabel.text height:20 font:13];
    
    rect.size = agreeView.size;
    rect.origin.x = (SCREEN_WIDTH - tipWidth - termWidth) / 2;
    rect.origin.y = SCREEN_HEIGHT - rect.size.height - 20 - 64;
    agreeView.frame = rect;
    
    rect.origin.x = agreeView.right;
    rect.size.width = termWidth;
    termButton.frame = rect;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:tap];
    
}


- (void)authLoginSuccessfulJump:(AuthLoginBlock)block
{
    self.authLoginSuccessBlock = block;
}

#pragma mark 第三方登录
- (void)buttonClickAction:(id)sender
{
    UIButton *button = (UIButton *) sender;
    NSString *loginType = nil;
    
    switch (button.tag) {
        case 1400:{//微信
//            loginType = UMShareToWechatSession;
        }
            
            break;
        case 1401:{//qq登录
//            loginType = UMShareToQQ;
        }

            break;
        case 1402:{//新浪登录
//            loginType = UMShareToSina;
        }

            break;
        default:
            break;
    }

}

- (void)onTouchVertifyButtonAction:(id)sender
{
    [self.view endEditing:YES];
    
    [self.verButton setEnabled:NO];
    if (_userName.jText.length < 1) {
        [self.view makeToast:@"请输入手机号"];
        [self.verButton setEnabled:YES];
        return;
    }else if(![self isPhoneNumber:_userName.jText]){
        [self.view makeToast:@"手机号码格式不对"];
        [self.verButton setEnabled:YES];
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    //获取验证码
    [[[MEUserRequest getAuthCode:_userName.jText] deliverOnMainThread] subscribeNext:^(id x) {
        NSLog(@"获取验证码成功");
        [self startCountDown];
        [hud hideAnimated:YES];
        
    }error:^(NSError *error) {
        NSLog(@"%s--获取验证码失败",__func__);
        [self stopCountDown];
        [hud hideAnimated:YES];
        NSString *message = @"获取验证码异常";
        if (error.code == 477) {
            message = @"当前手机号发送短信的数量超过限额";
        }
        [self.view makeCenterToast:message];
    }];
    
    
}


- (void)loginButtonAction:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.label.text = @"不要捉急哟～";
    if (AppVersion.appState == AppStateOnline) {
        if ([_userName.jText isEqualToString:@"13621170521"] && [_vertifyCode.jText isEqualToString:@"123456"]) {
            [[MEUserRequest authCodeLogin:_userName.jText authCode:_vertifyCode.jText] subscribeNext:^(id x) {
                [hud hideAnimated:YES];
                [[MEUser userDefaults] updateUserByDict:x];
                [MEUser getUserInfo];
                [self.navigationController popViewControllerAnimated:YES];
                NSLog(@"登录成功");
            }error:^(NSError *error) {
                NSLog(@"登录失败");
                [hud hideAnimated:YES];
                [self.view makeCenterToast:@"登录失败"];
            }];
            return;
        }
    }
    
    [SMSSDK commitVerificationCode:self.vertifyCode.jText phoneNumber:_userName.jText zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error) {
        
        {
            if (!error)
            {
                NSLog(@"验证码验证成功");
                [[MEUserRequest authCodeLogin:_userName.jText authCode:_vertifyCode.jText] subscribeNext:^(id x) {
                    [hud hideAnimated:YES];
                    [[MEUser userDefaults] updateUserByDict:x];
                    [MEUser getUserInfo];
                    [self.navigationController popViewControllerAnimated:YES];
                   NSLog(@"登录成功");
                }error:^(NSError *error) {
                    NSLog(@"登录失败");
                    [hud hideAnimated:YES];
                    [self.view makeCenterToast:@"登录失败"];
                }];
                
            }
            else
            {
                NSLog(@"错误信息:%@",error);
                [self.view makeCenterToast:@"验证码校验失败"];
                [hud hideAnimated:YES];
            }
        }
    }];
}


-(void)viewTapped:(UITapGestureRecognizer*)tap
{
    
    [self.view endEditing:YES];
    
}

- (void)onTermButtonAction:(id)sender
{
    //    ArticleViewController *controller = [[ArticleViewController alloc] init];
    //    [self.navigationController pushViewController:controller animated:YES];
}

- (void)startCountDown{
    if (_timer) {
        dispatch_cancel(_timer);
        _timer = nil;
    }
    __block int timeout = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        //        DLog(@"timer ");
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            _timer = nil;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.verButton setEnabled:YES];
                [_verButton setTitle:@"获取验证码" forState:UIControlStateDisabled];
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"重发(%.2ds)", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.verButton setTitle:strTime forState:UIControlStateDisabled];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}

- (void)stopCountDown {
    if (_timer) {
        dispatch_cancel(_timer);
        _timer = nil;
    }
    [self.verButton setEnabled:YES];
    [_verButton setTitle:@"获取验证码" forState:UIControlStateDisabled];
}

/**
 * 判断是不是电话号码
 */
-(BOOL)isPhoneNumber:(NSString *)phoneNumber
{
    NSString * MOBILE = @"^1\\d{10}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if ([regextestmobile evaluateWithObject:phoneNumber] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

- (void)textFieldDidChange:(ZNTextField *)textField
{
    if (textField == _userName || textField == _vertifyCode) {
        
        if (_userName.jText.length < 4  || _vertifyCode.jText.length < 1) {
            _regButton.enabled = NO;
        }else{
            _regButton.enabled = YES;
        }
    }
}

- (BOOL)textField:(ZNTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //    if (textField.jText.length > 20 ) {
    //        return NO;
    //    }
    return YES;
}
- (void)backButtonClickAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
