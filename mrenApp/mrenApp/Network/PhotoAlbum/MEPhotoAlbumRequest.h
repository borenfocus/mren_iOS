//
//  MEPhotoAlbumRequest.h
//  mrenApp
//
//  Created by zhouen on 16/12/3.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MEAlbum;
@interface MEPhotoAlbumRequest : HttpRequest

/**
 获取相册列表

 @param cid 一级分类ID
 @param page 页数
 @return xxx
 */
+ (RACSignal *)getPhotoAlbumListWithCid:(NSString *)cid  page:(NSInteger)page;



/**
 模糊查询相册列表
 
 @param  title 模糊查询
 @return xxx
 */
+ (RACSignal *)fuzzyQueryAlbumListByTitle:(NSString *)title page:(NSInteger)page;




/**
 获取相册图片列表

 @param photoUuid photoUuid
 @return xxx
 */
+ (RACSignal *)getAlbumImageListWithUuid:(NSString *)photoUuid;



/**
 更新相册信息  watch...

 @param photoAlbum MEAlbum 实体类
 @return xxx
 */
+ (RACSignal *)updatePhotoAlbum:(MEAlbum *)photoAlbum;

@end
