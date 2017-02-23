//
//  MEAlbum.h
//  mrenApp
//
//  Created by zhouen on 16/12/3.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEAlbum : NSObject

@property (nonatomic ,copy)     NSString    *uuid;          //UUID作为唯一键,用来做业务查询
@property (nonatomic ,copy)     NSString    *albumPath;
@property (nonatomic ,copy)     NSString    *imageUrl;      //相册 封面图片URL
@property (nonatomic ,copy)     NSString    *title;
@property (nonatomic ,assign)   NSInteger   imageWidth;
@property (nonatomic ,assign)   NSInteger   imageHeight;
@property (nonatomic ,assign)   long        imageSize;
@property (nonatomic ,assign)   NSInteger   state;          //该相册 是否展示 1
@property (nonatomic ,assign)   long        watch;
@property (nonatomic ,copy)     NSString    *source;        //图片来源
@property (nonatomic ,copy)     NSString    *createdTime;   //创建时间
@end
