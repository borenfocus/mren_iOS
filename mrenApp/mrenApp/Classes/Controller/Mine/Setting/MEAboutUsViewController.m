//
//  MEAboutUsViewController.m
//  mrenApp
//
//  Created by zhouen on 16/12/26.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MEAboutUsViewController.h"

@interface MEAboutUsViewController ()

@end

@implementation MEAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于妹子";
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    webView.backgroundColor = MAIN_COLOR;
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"aboutus" withExtension:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
