//
//  MEUserRequest.m
//  mrenApp
//
//  Created by zhouen on 16/12/10.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MEUserRequest.h"
#import <SMS_SDK/SMSSDK.h>

@implementation MEUserRequest


+ (void)getAuthCode:(NSString *)phoneNumber success:(ResponseSuccess)success failure:(ResponseFailure)failure {
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phoneNumber
                                   zone:@"86"
                       customIdentifier:nil
                                 result:^(NSError *error){
                                     if (!error) {
                                         if (success) {
                                             success(@"success");
                                         }
                                     } else {
                                         if (failure) {
                                             failure(error);
                                         }
                                     }
                                 }];
}

+ (RACSignal *)getAuthCode:(NSString *)phoneNumber {
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self getAuthCode:phoneNumber success:^(id response) {
            [subscriber sendNext:response];
            [subscriber sendCompleted];
        } failure:^(id error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    return signal;
}



+ (void)authCodeLogin:(NSString *)phoneNumber authCode:(NSString *)authCode success:(ResponseSuccess)success failure:(ResponseFailure)failure {
    phoneNumber = phoneNumber ? phoneNumber : @"";
    authCode = authCode ? authCode : @"";
    NSDictionary *param = NSDictionaryOfVariableBindings(phoneNumber,authCode);
    [[self shareInstance] postRequestWithURL:URL_USER_AUTHLOGIN parameters:param success:^(id response) {
        
        [self handleResponse:response success:success failure:failure];
        
    } failure:^(id error) {
        NSLog(@"%s", __FUNCTION__);
        [self handleError:error failure:failure];
        
    }];

}


+ (RACSignal *)authCodeLogin:(NSString *)phoneNumber authCode:(NSString *)authCode {
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self authCodeLogin:phoneNumber authCode:authCode success:^(id response) {
            [subscriber sendNext:response];
            [subscriber sendCompleted];
        } failure:^(id error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    return signal;
}


+ (void)updateUserInfo:(NSDictionary *)userInfo success:(ResponseSuccess)success failure:(ResponseFailure)failure {
    
    [[self shareInstance] postRequestWithURL:URL_USER_UPDATEINFO parameters:userInfo success:^(id response) {
        
        [self handleResponse:response success:success failure:failure];
        
    } failure:^(id error) {
        NSLog(@"%s", __FUNCTION__);
        [self handleError:error failure:failure];
        
    }];
    
}

+ (RACSignal *)updateUserInfo:(NSDictionary *)userInfo {
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self updateUserInfo:userInfo success:^(id response) {
            [subscriber sendNext:response];
            [subscriber sendCompleted];
        } failure:^(id error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    return signal;
}

+ (void)getUserInfo:(NSString *)uuid success:(ResponseSuccess)success failure:(ResponseFailure)failure {
    uuid = uuid ? uuid : @"";
    NSDictionary *param = NSDictionaryOfVariableBindings(uuid);
    @weakify(self);
    [[self shareInstance] postRequestWithURL:URL_USER_GETINFO parameters:param success:^(id response) {
        @strongify(self);
        [self handleResponse:response success:success failure:failure];
        
    } failure:^(id error) {
        NSLog(@"%s", __FUNCTION__);
        @strongify(self);
        [self handleError:error failure:failure];
        
    }];
    
}

+ (RACSignal *)getUserInfo:(NSString *)uuid {
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self getUserInfo:(NSString *)uuid success:^(id response) {
            [subscriber sendNext:response];
            [subscriber sendCompleted];
        } failure:^(id error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
    return signal;

}

#pragma mark 上传头像
+ (void)uploadHeaderImage:(NSData *)data fileName:(NSString *)fileName success:(ResponseSuccess)success failure:(ResponseFailure)failure{
    NSString *uuid = User.uuid;
    NSDictionary *param = NSDictionaryOfVariableBindings(uuid);
    
    @weakify(self);
    [[self shareInstance] uploadWithURL:URL_UPLOAD_AVATAR data:data name:@"image" fileName:fileName params:param success:^(id response) {
        @strongify(self);
        [self handleResponse:response success:success failure:failure];
    } failure:^(id error) {
        @strongify(self);
        NSLog(@"%s", __FUNCTION__);
        [self handleError:error failure:failure];
    }];
}

+ (RACSignal *)uploadHeaderImage:(NSData *)data fileName:(NSString *)fileName {
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self uploadHeaderImage:data fileName:fileName success:^(id response) {
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
