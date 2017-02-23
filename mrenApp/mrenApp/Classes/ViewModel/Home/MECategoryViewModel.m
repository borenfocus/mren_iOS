//
//  MECategoryViewModel.m
//  mrenApp
//
//  Created by zhouen on 16/12/2.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MECategoryViewModel.h"
#import "MEPhotoCategoryRequest.h"
#import "MEPhotoCategory.h"

@interface MECategoryViewModel ()
@property (nonatomic ,strong)   NSArray<MEPhotoCategory*> *categories;
@end

@implementation MECategoryViewModel

- (instancetype)init {
    if (self = [super init]) {
        @weakify(self);
        [self.didBecomeActiveSignal subscribeNext:^(id x) {
            @strongify(self);
            [self p_getPhotoCategory_1];
        }];
    }
    return self;
}


- (void)requestPhotoCategory_1 {
    [self p_getPhotoCategory_1];
}

/** 获取相册一级分类 */
- (void)p_getPhotoCategory_1 {
    self.categories = [NSUserDefaults unarchiveObjectForKey:kDefaultsCategory1];
    [[[MEPhotoCategoryRequest getPhotoCategory] map:^id(id value) {
        return [MEPhotoCategory mj_objectArrayWithKeyValuesArray:value];
    }] subscribeNext:^(id x) {
        self.categories = [NSArray arrayWithArray:x];
        [NSUserDefaults setArchiveObject:x forKey:kDefaultsCategory1];
    }error:^(NSError *error) {
        if (_errorBlock) {
            _errorBlock(error);
        }
    }];
}

/** 获取相册二级分类 */
- (void)p_getPhotoCategory_2 {
    
}

@end
