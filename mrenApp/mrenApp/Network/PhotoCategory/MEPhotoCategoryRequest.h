//
//  MEPhotoCategoryRequest.h
//  mrenApp
//
//  Created by zhouen on 16/12/2.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEPhotoCategoryRequest : HttpRequest


/**
 获取相册一级分类
 */
+ (void)getPhotoCategory:(ResponseSuccess)success failure:(ResponseFailure)failure;
+ (RACSignal *)getPhotoCategory;

/**
 通过一级分类获取 二级分类
 */
+ (void)getPhotoCategoryByParentId:(NSString *)parentId success:(ResponseSuccess)success failure:(ResponseFailure)failure;
+ (RACSignal *)getPhotoCategoryByParentId:(NSString *)parentId;
@end
