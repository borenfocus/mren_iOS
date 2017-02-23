//
//  MEUserRequest.h
//  mrenApp
//
//  Created by zhouen on 16/12/10.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEUserRequest : HttpRequest


/**
 获取验证码

 @param phoneNumber 手机号
 @return xxx
 */
+ (RACSignal *)getAuthCode:(NSString *)phoneNumber;


/**
 手机号验证吗登录

 @param phoneNumber 手机号
 @return xxx
 */
+ (RACSignal *)authCodeLogin:(NSString *)phoneNumber authCode:(NSString *)authCode;

/**
 修改用户信息
 
 String userUuid // uuid 必须
 String nickname
 Integer sex
 String birthday
 */
+ (RACSignal *)updateUserInfo:(NSDictionary *)userInfo;


/**
 上传头像

 @param data 头像 data
 @param fileName 名称必须 .jpg .png
 @return xxx
 */
+ (RACSignal *)uploadHeaderImage:(NSData *)data fileName:(NSString *)fileName;

/**
 获取用户信息
 
 String uuid 
 */
+ (RACSignal *)getUserInfo:(NSString *)uuid;

@end
