//
//  MEMineViewController.m
//  mrenApp
//
//  Created by zhouen on 16/12/8.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MEMineViewController.h"
#import "ParallaxHeaderView.h"
#import "MESettingViewController.h"
#import "MEPersonalInfoViewController.h"
#import "MEAuthCodeLoginViewController.h"
#import "MEDonateViewController.h"
#import "MEItem.h"
#import "MESection.h"
#import "MEUser.h"

@interface MEMineViewController ()
@property (nonatomic, strong) UIWebView *callWebView;
@end

static NSString *const reuseIdentifier = @"mineCell";
@implementation MEMineViewController


#pragma mark ------ Lifecycle
- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self p_initData];
    [self p_setupSubview];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
//    [MEUser getUserInfo];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [(ParallaxHeaderView *)self.tableView.tableHeaderView refreshBlurViewForNewImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ------ setter getter


#pragma mark ------ Public
- (void)didClickedHeader {
    
    if ([MEUser isLogin]) {
        [self.navigationController pushViewController:[MEPersonalInfoViewController new] animated:YES];
    } else {
        [self.navigationController pushViewController:[MEAuthCodeLoginViewController new]animated:YES];
    }
    
}

#pragma mark ------ Private

- (void)p_setupSubview {

    ParallaxHeaderView *headerView = [ParallaxHeaderView parallaxHeaderViewWithImage:[UIImage imageNamed:@"mine_header"] forSize:CGSizeMake(SCREEN_WIDTH, 200)];
    [self.tableView setTableHeaderView:headerView];

    UIImageView *headBtn = [[UIImageView alloc] init];
    headBtn.userInteractionEnabled = YES;
    UIImage *placeHolder = [UIImage imageNamed:@"header_default"];
    [headBtn addTapGestureWithTarget:self action:@selector(didClickedHeader)];
    [self.tableView.tableHeaderView addSubview:headBtn];
    [headBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tableView.tableHeaderView).offset(20);
        make.bottom.equalTo(self.tableView.tableHeaderView).offset(-20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    headBtn.layer.cornerRadius = 30;
    headBtn.layer.masksToBounds = YES;
    
    [RACObserve(User, headPortrait) subscribeNext:^(id x) {
        NSURL *url = [NSURL URLWithString:[URLUtil getHeaderImagePath:x]];
        [headBtn sd_setImageWithURL:url placeholderImage:placeHolder];
    }];
    
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)p_initData {
    self.sections = @[[self p_getSection1],
                      [self p_getSection2],
                      [self p_getSection3]];
}

- (MESection *)p_getSection1 {
    @weakify(self);
    MEItem *item1 = [MEItem itemWithText:@"相册" imageName:@"mine_panda" actionBlock:^{
        @strongify(self);
        [self.view makeToast:@"哎呀嘛～这是什么鬼"
                    duration:1.0
                    position:CSToastPositionCenter];
        
    }];
    MEItem *item2 = [MEItem itemWithText:@"收藏" imageName:@"mine_pig" actionBlock:^{
        [self.view makeToast:@"哎呀嘛～小编还没睡醒呢"
                    duration:1.0
                    position:CSToastPositionCenter];
    }];
    MEItem *item3 = [MEItem itemWithText:@"广告投放" imageName:@"mine_sheep" actionBlock:^{
        @strongify(self);
        [self p_callAction];
    }];
    item3.detailText = @"call";
    
    MEItem *item4 = [MEItem itemWithText:@"合作投资" imageName:@"mine_frog" actionBlock:^{
        @strongify(self);
        [self p_callAction];
    }];
    item4.detailText = @"call";
    
    MESection *section = [[MESection alloc] init];
    section.items = @[item1 ,item2 ,item3, item4];
    section.headerHeight = 0.1f;
    return section;
}
- (MESection *)p_getSection2 {
    @weakify(self);
    MEItem *item1 = [MEItem itemWithText:@"资助小编" imageName:@"mine_hen" actionBlock:^{
        @strongify(self);
        [self.navigationController pushViewController:[MEDonateViewController new] animated:YES];
    }];
    MESection *section = [[MESection alloc] init];
    section.items = @[item1];
    return section;
}
- (MESection *)p_getSection3 {
    @weakify(self);
    MEItem *item1 = [MEItem itemWithText:@"设置" imageName:@"mine_crab" actionBlock:^{
        @strongify(self);
        [self.navigationController pushViewController:[MESettingViewController new] animated:YES];
    }];
    MESection *section = [[MESection alloc] init];
    section.items = @[item1];
    section.footerHeight = 0.1;
    return section;
}

//广告投放
- (void)p_callAction{
    NSURL *phoneURL = [NSURL URLWithString:@"tel:13621170521"];
    if (!_callWebView) {
        _callWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
    }
    [_callWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}


#pragma mark ------ Protocol
#pragma mark ------ UITextFieldDelegate
#pragma mark ------ UITableViewDataSource


#pragma mark ------ UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        [(ParallaxHeaderView *)self.tableView.tableHeaderView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
    }
}


@end
