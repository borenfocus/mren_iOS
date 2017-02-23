//
//  MEAppVersion.m
//  mrenApp
//
//  Created by zhouen on 16/12/16.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MEAppVersionRequest.h"

@implementation MEAppVersionRequest

+ (void)getAppVerisonInfo:(NSString *)appVersion success:(ResponseSuccess)success failure:(ResponseFailure)failure {
    appVersion = appVersion ? appVersion : @"";
    NSString *appDevice = @"iOS";
    NSDictionary *param = NSDictionaryOfVariableBindings(appVersion,appDevice);
    [[self shareInstance] postRequestWithURL:URL_USER_APPVERSION parameters:param success:^(id response) {
        
        [self handleResponse:response success:success failure:failure];
        
    } failure:^(id error) {
        NSLog(@"error= %s", __FUNCTION__);
        [self handleError:error failure:failure];
        
    }];
    
}

+ (RACSignal *)getAppVerisonInfo {
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self getAppVerisonInfo:version success:^(id response) {
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
