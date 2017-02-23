//
//  MEAlbumViewModel.m
//  mrenApp
//
//  Created by zhouen on 16/12/3.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MEAlbumViewModel.h"
#import "MEPhotoAlbumRequest.h"
#import "MEAlbum.h"

@interface MEAlbumViewModel ()
@property (nonatomic, copy)   NSString  *cid;
@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) RACCommand *refreshCommand;
@property (nonatomic, strong) RACCommand *nextPageCommand;

@property (nonatomic, strong) NSArray<MEAlbum *> *albums;
@end
@implementation MEAlbumViewModel

- (instancetype)init {
    if (self = [super init]) {
        @weakify(self);
        [self.didBecomeActiveSignal subscribeNext:^(id x) {
            @strongify(self);
        }];
    }
    return self;
}


- (void)getPhotoAlbumListWithCid:(NSString *)cid {
    _cid = cid;
    [self firtPage];

}


/**
 *  获取第一页的数据
 */
- (RACSignal *)p_getTheFistData {

    self.currentPage = 0;
    return [MEPhotoAlbumRequest getPhotoAlbumListWithCid:_cid page:_currentPage];
}

- (RACSignal *)p_getNextPageData {
    
    return [MEPhotoAlbumRequest  getPhotoAlbumListWithCid:_cid page:++_currentPage];
    
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
+ (void)updatePhotoAlbum:(MEAlbum *)album{
    
    [[MEPhotoAlbumRequest updatePhotoAlbum:album] subscribeNext:^(id x) {
        
    }];
}
@end
