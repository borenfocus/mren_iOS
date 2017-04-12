//
//  MEHomeListViewController.m
//  mrenApp
//
//  Created by zhouen on 16/12/1.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MEHomeListViewController.h"
#import "MEHomeCollectionViewCell.h"
#import "MEPhotoCategory.h"
#import "MEAlbum.h"
#import "MEAlbumViewModel.h"
#import "MEPhotoBrowser.h"
#import "ZNWaterfallLayout.h"

@interface MEHomeListViewController ()<ZNWaterfallLayoutDelegate,IDMPhotoBrowserDelegate>

@property(nonatomic,strong)     NSArray *heightArr;
@property (nonatomic, strong)   ZNWaterfallLayout *layout;

@property (nonatomic, strong) MEAlbumViewModel *albumViewModel;
@end

static NSString * const reuseIdentifier = @"Cell";
@implementation MEHomeListViewController

#pragma mark ------ Lifecycle
-(instancetype)init{
    return  [super initWithCollectionViewLayout:self.layout];
}
- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = MAIN_COLOR;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MEHomeCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self initObserver];
    [self initRefresh];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

- (MEAlbumViewModel *)albumViewModel {
    if (!_albumViewModel) {
        _albumViewModel = [[MEAlbumViewModel alloc] init];
    }
    return _albumViewModel;
}

- (void)setCategory:(MEPhotoCategory *)category {
    _category = category;
    if (_category) {
        [self.albumViewModel getPhotoAlbumListWithCid:_category.cid];
    }
}

#pragma mark ------ Public

- (CGFloat)waterfallLayout:(ZNWaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath {
    MEAlbum *album = self.albumViewModel.albums[indexPath.item];
    return album.imageHeight * itemWidth /album.imageWidth;
    
//    return [self.heightArr[indexPath.item] floatValue];
}

- (void)initRefresh {
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.albumViewModel firtPage];
        if (isNil(self.albumViewModel.albums)) {
            [self.collectionView showState:HudStateLoading tapBlock:nil];
        }
        
    }];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.albumViewModel nextPage];
    }];
}

- (void)initObserver {
    @weakify(self);
    [[[RACObserve(self.albumViewModel, albums) skip:1] deliverOn:[RACScheduler mainThreadScheduler] ] subscribeNext:^(NSArray *x) {
        @strongify(self);
        if (x.count == 0) {
            [self.collectionView showState:HudStateNoData tapBlock:^{
                [self p_requestData];
            }];
            
        } else {
            [self.collectionView hideHud];
        }
        [self.collectionView stopRefresh];
        [self.collectionView reloadData];
    }];
    
    //请求失败 或 无更多数据
    self.albumViewModel.refreshError = ^(id error){
        @strongify(self);
        [self.collectionView stopRefresh];
        
        if (isNil(self.albumViewModel.albums)) {
            [self.collectionView showState:HudStateError tapBlock:^{
                [self p_requestData];
            }];
        }
        
    };
}

#pragma mark ------ Private

- (void)p_requestData {
    [self.collectionView.mj_header beginRefreshing];
}


#pragma mark ------ Protocol
    
#pragma mark ------ UITextFieldDelegate
#pragma mark ------ UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [self.albumViewModel.albums count];
    
//    return self.heightArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MEHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    MEAlbum *album = self.albumViewModel.albums[indexPath.item];
    cell.album = album;
    
    return cell;
}

#pragma mark ------ UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MEHomeCollectionViewCell* cell = (MEHomeCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    MEAlbum *album = self.albumViewModel.albums[indexPath.item];
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
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    //scrollView已经有拖拽手势，直接拿到scrollView的拖拽手势
//    UIPanGestureRecognizer *pan = scrollView.panGestureRecognizer;
//    //获取到拖拽的速度 >0 向下拖动 <0 向上拖动
//    CGFloat velocity = [pan velocityInView:scrollView].y;
//    
//    if (velocity <- 5) {
//        //向上拖动，隐藏导航栏
////        [self.navigationController setNavigationBarHidden:YES animated:YES];
////        self.tabBarController.tabBar.hidden = NO;
//    }else if (velocity > 5) {
//        //向下拖动，显示导航栏
////        [self.navigationController setNavigationBarHidden:NO animated:YES];
////        self.tabBarController.tabBar.hidden = YES;
//    }else if(velocity == 0){
//        //停止拖拽
//    }
//}


-(NSArray *)heightArr{
    if(!_heightArr){
        //随机生成高度
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i<100; i++) {
            [arr addObject:@(arc4random()%50+80)];
        }
        _heightArr = [arr copy];
    }
    return _heightArr;
}

@end
