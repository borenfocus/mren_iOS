//
//  MESearchViewModel.m
//  mrenApp
//
//  Created by zhouen on 16/12/27.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MESearchViewModel.h"
#import "MEAlbum.h"
#import "MEPhotoAlbumRequest.h"

@interface MESearchViewModel ()
@property (nonatomic, copy)   NSString  *queryTitle;
@property (nonatomic, assign) NSInteger currentPage;


@property (nonatomic, strong) NSArray<MEAlbum *> *albums;
@end
@implementation MESearchViewModel

- (instancetype)initWithFuzzyTitle:(NSString *)title {
    if (self = [super init]) {
        _queryTitle = title;
        
        @weakify(self);
        [self.didBecomeActiveSignal subscribeNext:^(id x) {
            @strongify(self);
            [self fuzzyQueryAlbumListByTitle:title];
        }];
    }
    return self;
}


- (void)fuzzyQueryAlbumListByTitle:(NSString *)queryTitle {
    _queryTitle = queryTitle;
    [self firtPage];
    
}


/**
 *  获取第一页的数据
 */
- (RACSignal *)p_getTheFistData {
    
    self.currentPage = 0;
    return [MEPhotoAlbumRequest fuzzyQueryAlbumListByTitle:_queryTitle page:_currentPage];
}

- (RACSignal *)p_getNextPageData {
    
    return [MEPhotoAlbumRequest  fuzzyQueryAlbumListByTitle:_queryTitle page:++_currentPage];
    
}

- (void)firtPage {
    @weakify(self);
    [[[self p_getTheFistData] map:^id(id value) {
        return [MEAlbum mj_objectArrayWithKeyValuesArray:value];
    }] subscribeNext:^(id x) {
        @strongify(self);
        self.albums = [NSArray arrayWithArray:x];
    } error:^(NSError *error) {
        if (_refreshError) {
            _refreshError(error);
        }
    }];
}

- (void)nextPage {
    @weakify(self);
    [[[self p_getNextPageData] map:^id(id value) {
        return [MEAlbum mj_objectArrayWithKeyValuesArray:value];
    }] subscribeNext:^(NSArray *x) {
        @strongify(self);
        if (x.count > 0) {
            NSMutableArray *array = [NSMutableArray arrayWithArray:self.albums];
            [array addObjectsFromArray:x];
            self.albums = [NSArray arrayWithArray:array];
        } else {
            if (_refreshError) {
                _refreshError(nil);
            }
        }
    } error:^(NSError *error) {
        if (_refreshError) {
            _refreshError(error);
        }
    }];
    
}

@end


