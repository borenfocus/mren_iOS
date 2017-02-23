//
//  MEDonateViewController.m
//  mrenApp
//
//  Created by zhouen on 16/12/26.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MEDonateViewController.h"

@interface MEDonateViewController ()

@end

@implementation MEDonateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *image = [[UIImageView alloc] initWithFrame:self.view.bounds];
    image.image = [UIImage imageNamed:@"pay"];
    image.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:image];
    
    
    UILabel *pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, SCREEN_HEIGHT - 64, SCREEN_WIDTH -20, 40)];
    pointLabel.text = @"将二维码保存到相册，微信内部扫描相册就可以资助小编了哟😊";
    pointLabel.textAlignment = NSTextAlignmentCenter;
    pointLabel.font = [UIFont systemFontOfSize:15];
    pointLabel.numberOfLines = 0;
    [self.view addSubview:pointLabel];
    
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]
                                 initWithTitle:@"保存二维码"
                                 style:UIBarButtonItemStyleDone
                                 target:self
                                 action:@selector(saveBtn)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"微信资助";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveBtn {
     UIImage *image = [UIImage imageNamed:@"pay"];
     UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}\
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error == nil) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已存入手机相册" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定" , nil];
        [alert show];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
