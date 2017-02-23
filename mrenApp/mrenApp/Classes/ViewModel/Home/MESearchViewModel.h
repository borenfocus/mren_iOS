//
//  MESearchViewModel.h
//  mrenApp
//
//  Created by zhouen on 16/12/27.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <ReactiveViewModel/ReactiveViewModel.h>
@class  MEAlbum;
@interface MESearchViewModel : RVMViewModel

@property (nonatomic, readonly) NSArray<MEAlbum *> *albums;

//请求失败 或 无更多数据
@property (nonatomic, copy) void(^ refreshError)(id error);




- (instancetype)initWithFuzzyTitle:(NSString *)title;

/**
 模糊查询相册列表
 
 @param queryTitle title
 */
- (void)fuzzyQueryAlbumListByTitle:(NSString *)queryTitle;

- (void)firtPage;
- (void)nextPage;
@end
