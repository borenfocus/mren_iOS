//
//  MESearchResultViewController.m
//  mrenApp
//
//  Created by zhouen on 16/12/27.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MESearchResultViewController.h"
#import "MEHomeCollectionViewCell.h"
#import "MESearchViewModel.h"
#import "MEAlbumViewModel.h"
#import "MEPhotoBrowser.h"
#import "ZNWaterfallLayout.h"
#import "MEAlbum.h"
#import "MEPhotoBrowser.h"
@interface MESearchResultViewController ()<ZNWaterfallLayoutDelegate,IDMPhotoBrowserDelegate>

@property (nonatomic, strong)   ZNWaterfallLayout *layout;
@property (nonatomic, copy) NSString *fuzzyTitle;
@property (nonatomic, strong) MESearchViewModel *searchViewModel;
@end

static NSString * const reuseIdentifier = @"SearchCell";
@implementation MESearchResultViewController

-(instancetype)init{
    return  [super initWithCollectionViewLayout:self.layout];
}

#pragma mark ------ Lifecycle
- (instancetype)initWithFuzzyTitle:(NSString *)title {
    self = [super initWithCollectionViewLayout:self.layout];
    if (self) {
        _fuzzyTitle = title;
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MAIN_COLOR;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MEHomeCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initObserver];
    [self initRefresh];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = _fuzzyTitle;
    self.searchViewModel.active = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.searchViewModel.active = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ------ setter getter
- (MESearchViewModel *)searchViewModel {
    if (!_searchViewModel) {
        _searchViewModel = [[MESearchViewModel alloc] initWithFuzzyTitle:_fuzzyTitle];
    }
    return _searchViewModel;
}

#pragma mark ------ setter getter
- (UICollectionViewLayout *)layout {
    if(!_layout){
        _layout = [[ZNWaterfallLayout alloc] init];
        _layout.delegate = self;
        //设置各属性的值
        _layout.rowSpacing = 4;
        _layout.columnSpacing = 4;
        _layout.columnCount = 2;
        _layout.sectionInset = UIEdgeInsetsMake(0, 0, 10, 0);
    }
    return _layout;
}


#pragma mark ------ Public
- (void)initObserver {
    @weakify(self);
    [[RACObserve(self.searchViewModel, albums) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSArray *x) {
        @strongify(self);
        if (x.count == 0) {
            [self.collectionView showState:HudStateNoData tapBlock:^{
                [self.collectionView.mj_header beginRefreshing];
            }];

        } else {
            [self.collectionView hideHud];
        }
        [self.collectionView stopRefresh];
        [self.collectionView reloadData];
    }];
    
    //请求失败 或 无更多数据
    self.searchViewModel.refreshError = ^(id error){
        @strongify(self);
        [self.collectionView stopRefresh];
        
        if (isNil(self.searchViewModel.albums)) {
            [self.collectionView showState:HudStateError tapBlock:^{
                [self.collectionView.mj_header beginRefreshing];
            }];
        } else {
            [self.collectionView hideHud];
        }
        
    };
}

- (void)initRefresh {
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (isNil(self.searchViewModel.albums)) {
            [self.collectionView showState:HudStateLoading tapBlock:nil];
        } else {
            [self.collectionView hideHud];
        }
        [self.searchViewModel firtPage];
    }];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (isNil(self.searchViewModel.albums)) {
            [self.collectionView showState:HudStateLoading tapBlock:nil];
        } else {
            [self.collectionView hideHud];
        }
        [self.searchViewModel nextPage];
    }];
}

#pragma mark ------ Private


#pragma mark ------ Protocol
- (CGFloat)waterfallLayout:(ZNWaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath {
    MEAlbum *album = self.searchViewModel.albums[indexPath.item];
    return album.imageHeight * itemWidth /album.imageWidth;
    
    //    return [self.heightArr[indexPath.item] floatValue];
}
#pragma mark ------ UITextFieldDelegate
#pragma mark ------ UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.searchViewModel.albums count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MEHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    MEAlbum *album = self.searchViewModel.albums[indexPath.item];
    cell.album = album;
    
    return cell;
}

#pragma mark ------ UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MEHomeCollectionViewCell* cell = (MEHomeCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    MEAlbum *album = self.searchViewModel.albums[indexPath.item];
    NSArray *photos = @[[URLUtil getAlbumImagePath:album.imageUrl]];
    
    MEPhotoBrowser *browser = [[MEPhotoBrowser alloc] initWithPhotoURLs:photos animatedFromView:cell.coverImage];
    browser.nav = self.navigationController;
    browser.album = album;
    browser.delegate = self;
    browser.dismissOnTouch = YES;
    browser.displayActionButton = NO;
    browser.displayArrowButton = YES;
    browser.displayCounterLabel = YES;
    browser.usePopAnimation = YES;
    browser.scaleImage = cell.coverImage.image;
    
    [self.navigationController presentViewController:browser animated:NO completion:nil];
    
    //添加watch
    album.watch +=1;
    [MEAlbumViewModel updatePhotoAlbum:album];
    
}
#pragma mark ------ UIScrollViewDelegate
#pragma mark ------ Override

@end
