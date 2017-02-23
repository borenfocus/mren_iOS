//
//  MEAlbumImageViewModel.m
//  mrenApp
//
//  Created by zhouen on 16/12/5.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MEAlbumImageViewModel.h"
#import "MEPhotoAlbumRequest.h"
#import "MEAlbumImage.h"
@interface  MEAlbumImageViewModel()
@property (nonatomic, copy) NSString *photoUuid;
@property (nonatomic, strong) NSArray<MEAlbumImage *> *images;
@end

@implementation MEAlbumImageViewModel
- (instancetype)initWithPhotoUuid:(NSString *)photoUuid {
    if (self = [super init]) {
        @weakify(self);
        self.photoUuid = photoUuid;
        [self.didBecomeActiveSignal subscribeNext:^(id x) {
            @strongify(self);
            [self requestImageList];
        }];
    }
    return self;
}

- (void)requestImageList {
    @weakify(self);
    [[[[self p_getAlbumImageList] filter:^BOOL(NSArray *value) {
        return value && value.count > 0;
    }] map:^id(id value) {
        return [MEAlbumImage mj_objectArrayWithKeyValuesArray:value];
    }] subscribeNext:^(NSArray *x) {
        @strongify(self);
        self.images = [NSArray arrayWithArray:x];
    }];
}

- (RACSignal *)p_getAlbumImageList {
    return [MEPhotoAlbumRequest getAlbumImageListWithUuid:self.photoUuid];
}
@end
