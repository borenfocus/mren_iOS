//
//  MEPhotoBrowser.m
//  mrenApp
//
//  Created by zhouen on 16/12/7.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MEPhotoBrowser.h"
#import "MEAuthCodeLoginViewController.h"
#import "IDMPhotoBrowser.h"
#import "MEAlbumImage.h"
#import "MEAlbumImageViewModel.h"
#import "MEAlbum.h"
#import "AppDelegate.h"
#import <CoreMotion/CoreMotion.h>
#import <objc/message.h>
#import "MEActionSheet.h"
#import <UMSocialCore/UMSocialCore.h>

@interface MEPhotoBrowser ()<MEActionSheetDelegate>
@property (nonatomic, strong) CMMotionManager * motionManager;

@property (nonatomic, strong) MEAlbumImageViewModel *imageViewModel;
@end

@implementation MEPhotoBrowser

#pragma mark ------ Lifecycle
- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
    AllowRotation(NO);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageViewModel = [[MEAlbumImageViewModel alloc] initWithPhotoUuid:_album.uuid];
    
    [self p_initObserver];
    
    
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    longPressGr.minimumPressDuration = 1.0;
    [self.view addGestureRecognizer:longPressGr];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.imageViewModel.active = YES;
    AllowRotation(YES);
}

- (void)viewWillDisappear:(BOOL)animated {
    self.imageViewModel.active = NO;
    AllowRotation(NO);
    [self interfaceOrientation:UIInterfaceOrientationPortrait];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ------ setter getter
-(void)setAlbum:(MEAlbum *)album{
    _album = album;
}

#pragma mark ------ Public


#pragma mark ------ Private
- (void)p_initObserver {
    @weakify(self);
    [[RACObserve(self.imageViewModel, images) filter:^BOOL(id value) {
        return value;
    }] subscribeNext:^(NSArray *x) {
        @strongify(self);
        NSMutableArray *array = [NSMutableArray array];
        for (MEAlbumImage *image in x) {
            IDMPhoto *photo = [IDMPhoto photoWithURL:[NSURL URLWithString:[URLUtil getAlbumImagePath:image.imageUrl]]];
            photo.caption = _album.title;
            [array addObject:photo];
        }
        self.photos = [[NSMutableArray alloc] initWithArray:array];
        [self reloadData];
    }];
    
}

- (void)downloadImage {
    if (![MEUser isLogin]) {
        [self.view makeCenterToast:@"个人中心点击头像登录后方可下载吆～"];
        return;
    }
    [super downloadImage];
}

- (void)longPressToDo:(UILongPressGestureRecognizer *)gesture {
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        MEActionSheet *sheet = [[MEActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitle:@"微博", nil];
        [sheet setCancelButtonTitleColor:[UIColor blackColor] fontSize:0];
        [sheet setButtonTitleColor:[UIColor blackColor] fontSize:0];
        [sheet show];
    }
    
}



//强制转屏
- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
    [[UIDevice currentDevice] setValue:@(orientation)forKey:@"orientation"];
}


#pragma mark ------ Protocol
#pragma mark ------ MEActionSheetDelegate
- (void)actionSheet:(MEActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0://微博
            [self shareToSina];
            break;
        case 1:
//            [self p_openPhotoAlbum];//打开相册
            break;
            
        default:
            break;
    }
}

- (void)shareToSina {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //设置文本
    messageObject.text = [NSString stringWithFormat:@"%@\n高清大尺度美女图片、劲爆短视频尽在Oxy。 %@ - [iOS版本app]",_album.title,kItunesUrl];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = [UIImage imageNamed:@"icon"];
    
    NSString *imageUrl = nil;
    if (self.imageViewModel.images.count >= self.currentPageIndex) {
        MEAlbumImage *image = self.imageViewModel.images[self.currentPageIndex];
        imageUrl = [URLUtil getAlbumImagePath:image.imageUrl];
    }
    [shareObject setShareImage:imageUrl];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Sina messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}
#pragma mark ------ UITextFieldDelegate
#pragma mark ------ UITableViewDataSource
#pragma mark ------ UITableViewDelegate
#pragma mark ------ UIScrollViewDelegate


@end
