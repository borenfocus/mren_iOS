//
//  MEPhotoCategoryRequest.m
//  mrenApp
//
//  Created by zhouen on 16/12/2.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MEPhotoCategoryRequest.h"

@implementation MEPhotoCategoryRequest

+ (void)getPhotoCategory:(ResponseSuccess)success failure:(ResponseFailure)failure {
    [[HttpRequest shareInstance] getRequestWithURL:URL_PHOTO_CATEGORY1 parameters:nil success:^(id response) {
        [self handleResponse:response success:success failure:failure];
    } failure:^(id error) {
        [self handleError:error failure:failure];
    }];
}

+ (RACSignal *)getPhotoCategory {
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self getPhotoCategory:^(id response) {
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
