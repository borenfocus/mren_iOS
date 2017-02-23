//
//  MEAlbumViewModel.h
//  mrenApp
//
//  Created by zhouen on 16/12/3.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <ReactiveViewModel/ReactiveViewModel.h>
@class MEAlbum;
@interface MEAlbumViewModel : RVMViewModel

@property (nonatomic, readonly) NSArray<MEAlbum *> *albums;

//请求失败 或 无更多数据
@property (nonatomic, copy) void(^ refreshError)(id error);



/**
 获取相册列表

 @param cid 分类ID
 */
- (void)getPhotoAlbumListWithCid:(NSString *)cid;


/**
 更新相册信息
 */
+ (void)updatePhotoAlbum:(MEAlbum *)album;


- (void)firtPage;
- (void)nextPage;
@end
