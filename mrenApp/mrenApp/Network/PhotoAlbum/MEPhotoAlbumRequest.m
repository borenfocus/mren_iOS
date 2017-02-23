//
//  MEPhotoAlbumRequest.m
//  mrenApp
//
//  Created by zhouen on 16/12/3.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MEPhotoAlbumRequest.h"
#import "MEAlbum.h"

static NSInteger const ROWS_NUMBER = 20;
@implementation MEPhotoAlbumRequest

+ (void)getPhotoAlbumListWithCid:(NSString *)cid  page:(NSInteger)page success:(ResponseSuccess)success failure:(ResponseFailure)failure {

    NSString *categoryId = cid;
    NSNumber *start =  @(ROWS_NUMBER * page);
    NSNumber *rows  =  @(ROWS_NUMBER);
    NSNumber *state =  @(AppVersion.appState);
    
    NSDictionary *param = NSDictionaryOfVariableBindings(categoryId,start,rows,state);
    
    [[self shareInstance] postRequestWithURL:URL_PHOTO_ALBUM parameters:param success:^(id response) {
        
        [self handleResponse:response success:success failure:failure];
        
    } failure:^(id error) {
        
        [self handleError:error failure:failure];
    }];
}

+ (RACSignal *)getPhotoAlbumListWithCid:(NSString *)cid  page:(NSInteger)page {
    @weakify(self);
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self getPhotoAlbumListWithCid:cid page:page success:^(id response) {
            [subscriber sendNext:response];
            [subscriber sendCompleted];
        } failure:^(id error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    return signal;
}


+ (void)fuzzyQueryAlbumListByTitle:(NSString *)title page:(NSInteger)page success:(ResponseSuccess)success failure:(ResponseFailure)failure {
    
    title =  title ? title : @"";
    NSNumber *start =  @(ROWS_NUMBER * page);
    NSNumber *rows  =  @(ROWS_NUMBER);
    NSNumber *state =  @(AppVersion.appState);
    
    NSDictionary *param = NSDictionaryOfVariableBindings(title,start,rows,state);
    
    [[self shareInstance] postRequestWithURL:URL_PHOTO_FUZZYQUERY parameters:param success:^(id response) {
        
        [self handleResponse:response success:success failure:failure];
        
    } failure:^(id error) {
        NSLog(@"%s", __FUNCTION__);
        [self handleError:error failure:failure];
        
    }];
}

+ (RACSignal *)fuzzyQueryAlbumListByTitle:(NSString *)title page:(NSInteger)page {
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self fuzzyQueryAlbumListByTitle:title page:page success:^(id response) {
            [subscriber sendNext:response];
            [subscriber sendCompleted];
        } failure:^(id error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    return signal;
    
}




+ (void)getAlbumImageListWithUuid:(NSString *)photoUuid success:(ResponseSuccess)success failure:(ResponseFailure)failure {
    
    photoUuid =  photoUuid ? photoUuid : @"";
    NSDictionary *param = NSDictionaryOfVariableBindings(photoUuid);
    
    [[self shareInstance] postRequestWithURL:URL_PHOTO_IMAGES parameters:param success:^(id response) {
        
        [self handleResponse:response success:success failure:failure];
        
    } failure:^(id error) {
        NSLog(@"%s", __FUNCTION__);
        [self handleError:error failure:failure];
        
    }];
}

+ (RACSignal *)getAlbumImageListWithUuid:(NSString *)photoUuid {
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self getAlbumImageListWithUuid:photoUuid success:^(id response) {
            [subscriber sendNext:response];
            [subscriber sendCompleted];
        } failure:^(id error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    return signal;

}

    
+ (void)updatePhotoAlbum:(MEAlbum *)photoAlbum success:(ResponseSuccess)success failure:(ResponseFailure)failure {
    NSDictionary *param = photoAlbum.mj_keyValues;
    
    [[self shareInstance] postRequestWithURL:URL_ALBUM_UPDATE parameters:param success:^(id response) {
        
        [self handleResponse:response success:success failure:failure];
        
    } failure:^(id error) {
        NSLog(@"%s", __FUNCTION__);
        [self handleError:error failure:failure];
        
    }];
}
    
+ (RACSignal *)updatePhotoAlbum:(MEAlbum *)photoAlbum {
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self updatePhotoAlbum:photoAlbum success:^(id response) {
            [subscriber sendNext:response];
            [subscriber sendCompleted];
        } failure:^(id error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    return signal;
    
}
@end
