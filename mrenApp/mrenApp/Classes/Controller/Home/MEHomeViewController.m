//
//  MEHomeViewController.m
//  mrenApp
//
//  Created by zhouen on 16/12/1.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MEHomeViewController.h"
#import "MEHomeListViewController.h"
#import "PYSearchViewController.h"
#import "MESearchResultViewController.h"
#import "ZNChannelView.h"
#import "MEPhotoCategory.h"
#import "CustomIOSAlertView.h"
#import "MEUpdateInfoView.h"

#import "MECategoryViewModel.h"

@interface MEHomeViewController ()<PYSearchViewControllerDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
ChannelViewDelegate>

@property (nonatomic, strong)   UICollectionView        *collectionView;
@property (nonatomic ,strong)   ZNChannelView           *channelView;
@property (nonatomic, strong)   UIButton                *searchBar;

@property (nonatomic ,strong)   NSMutableDictionary     *viewControllers;

@property (nonatomic ,strong)   MECategoryViewModel     *categoryViewModel;

@end


static NSString *const reuserIdentifer = @"collectionCell";

@implementation MEHomeViewController

#pragma mark ------ Lifecycle
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = MAIN_COLOR;
    
    [self p_setupSubview];
    [self p_initObserver];
    [self p_checkUpdate];
    
    [self showHudWithState:HudStateLoading tapBlock:^{
        NSLog(@"loading");
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.titleView = self.searchBar;
    
    if (!self.categoryViewModel.categories ) {
        self.categoryViewModel.active = YES;
    }
    
    if (AppVersion.appState == AppStateOnline) {
        [MEAppVersion requestAppVersion];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.categoryViewModel.active = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ------ setter getter

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.bounces = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuserIdentifer];
    }
    return _collectionView;
}

- (NSMutableDictionary *)viewControllers {
    if (!_viewControllers) {
        _viewControllers =[NSMutableDictionary dictionary];
    }
    return _viewControllers;
}

- (ZNChannelView *)channelView {
    if (!_channelView) {
        _channelView = [[ZNChannelView alloc] initWithFrame:CGRectZero selectColor:THEME_COLOR];
        _channelView.delegate = self;
        _channelView.backgroundColor = [UIColor whiteColor];
    }
    return _channelView;
}

- (UIButton *)searchBar {
    CGRect mainViewBounds = self.navigationController.view.bounds;
    _searchBar = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(mainViewBounds)/2-((CGRectGetWidth(mainViewBounds)-20)/2), 27, CGRectGetWidth(mainViewBounds)-20, 30)];
    [_searchBar setImage:[UIImage imageNamed:@"search20"] forState:UIControlStateNormal];
    [_searchBar setTitle:@"搜索" forState:UIControlStateNormal];
    _searchBar.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [_searchBar setAdjustsImageWhenHighlighted:NO];
    [_searchBar setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _searchBar.titleLabel.font = [UIFont systemFontOfSize:12];
    _searchBar.layer.cornerRadius = 4.0;
    _searchBar.layer.masksToBounds = YES;
    _searchBar.backgroundColor = [UIColor whiteColor];
    [_searchBar addTarget:self action:@selector(p_searchBarAction) forControlEvents:UIControlEventTouchUpInside];
    return _searchBar;
}
- (MECategoryViewModel *)categoryViewModel {
    if (!_categoryViewModel) {
        _categoryViewModel = [[MECategoryViewModel alloc] init];
    }
    return _categoryViewModel;
}

#pragma mark ------ Public


#pragma mark ------ Private
- (void)p_setupSubview {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 0.1)];
    [self.view addSubview:view];
    [self.view addSubview:self.channelView];
    [self.channelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(64));
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.channelView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
}

//重新获取分类数据
- (void)p_reloadCategory {
    [self showHudWithState:HudStateLoading tapBlock:^{
        NSLog(@"loading");
    }];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.categoryViewModel requestPhotoCategory_1];
    });
    
}

//检查更新
- (void)p_checkUpdate {
    [RACObserve(AppVersion,appState) subscribeNext:^(id x) {
        [self.collectionView reloadData];
        [self.categoryViewModel requestPhotoCategory_1];
        NSInteger state = [x integerValue];
        if (state == AppStateUpdate) {
            CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
            [alertView setContainerView:[MEUpdateInfoView updateViewWithMessage:AppVersion.appDescription]];
            [alertView setButtonTitles:@[@"去更新"]];
            [alertView show];
            [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
                
                NSString *url = [NSString stringWithFormat: @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@",  @"1191484225"];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
                
            }];
        }
    }];
    
}

//数据监听
- (void)p_initObserver {
    
    @weakify(self);
    
    [[RACObserve(self.categoryViewModel, categories) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        @strongify(self);
        [self hideHud];
        
        NSArray *array = x;
        NSMutableArray *channels = [NSMutableArray arrayWithCapacity:array.count];
        for (MEPhotoCategory *category in array) {
            [channels addObject:category.name];
        }
        self.channelView.channels = channels;
        
        [self.collectionView reloadData];
    }];
    
    self.categoryViewModel.errorBlock = ^(id error){
        @strongify(self);
        [self showHudWithState:HudStateError tapBlock:^{
            [self p_reloadCategory];
        }];
    };
    
    
    
}


//搜索
- (void)p_searchBarAction {
    // 1.创建热门搜索
    NSArray *hotSeaches = @[@"性感", @"黑丝", @"酥胸", @"翘臀", @"护士", @"气质", @"丁字裤", @"走光", @"蕾丝", @"学生妹", @"秘书", @"皮裤", @"透视", @"短裙"];
    if (AppVersion.appState == AppStateOnline) {
        hotSeaches = @[@"萌宠",@"美食",@"居家"];
    }
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索妹子" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        [searchViewController.navigationController pushViewController:[[MESearchResultViewController alloc] initWithFuzzyTitle:searchText] animated:YES];
    }];
    searchViewController.hotSearchStyle = PYHotSearchStyleColorfulTag;
    searchViewController.searchHistoryStyle = PYSearchHistoryStyleNormalTag;
    // 4. 设置代理
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器
    MEBaseNavigationController *nav = [[MEBaseNavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav  animated:NO completion:nil];
}


#pragma mark ------ Protocol

//点击某个分类
- (void)channelView:(ZNChannelView *)channelView didSelectIndex:(NSUInteger)index{
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

#pragma mark ------ UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.categoryViewModel.categories count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuserIdentifer forIndexPath:indexPath];
    [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSString *reuseIdentify = @(indexPath.row).stringValue;
    MEHomeListViewController * vc;
    if (!self.viewControllers[reuseIdentify]) {
        vc= [[MEHomeListViewController alloc] init];
        [self addChildViewController:vc];
        [self.viewControllers setObject:vc forKey:reuseIdentify];
        
    } else {
        vc= self.viewControllers[reuseIdentify];
        [cell addSubview:vc.view];
    }
    vc.view.frame = cell.bounds;
    vc.category = self.categoryViewModel.categories[indexPath.row];
    [cell addSubview:vc.view];
    return cell;
}

#pragma mark ------ UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.collectionView.bounds.size;
}


#pragma mark ------ UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.collectionView]) {
        [self.channelView scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.collectionView]) {
        [self.channelView scrollViewDidEndDecelerating:scrollView];
    }
}



#pragma mark - PYSearchViewControllerDelegate 建议
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    NSArray *array = @[@"大尺度",@"大胆",@"情趣",@"湿身" ,@"透视",@"透明",@"走光" ,@"性感",@"前凸后翘",@"女仆",@"极品",@"美乳",@"丝袜",@"比基尼",@"内衣",@"电臀",@"网袜",@"包臀裙",@"半球",@"大奶",@"事业线",@"湿身",@"车模",@"嫩模",@"校花",@"大长腿",@"情趣",@"办公室",@"御姐",@"蕾丝"];
    if (searchText.length) { // 与搜索条件再搜索
        // 根据条件发送查询（这里模拟搜索）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 搜索完毕
            // 显示建议搜索结果
            NSMutableSet *randomSet = [[NSMutableSet alloc] init];
            
            while ([randomSet count] < 10) {
                int r = arc4random() % [array count];
                [randomSet addObject:[array objectAtIndex:r]];
            }            // 返回
            searchViewController.searchSuggestions = [randomSet allObjects];
        });
    }
}



@end
