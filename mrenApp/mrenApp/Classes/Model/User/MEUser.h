//
//  LKGlobalUser.h
//  VChat
//
//  Created by zhouen on 16/8/31.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEUser : NSObject<NSCoding>
+ (MEUser *)userDefaults;
-(void)updateUserByDict:(NSDictionary *)dict;
-(void)clearGlobalUser;

@property (nonatomic, copy)      NSString    *uuid;
@property (nonatomic, copy)      NSString    *token;
@property (nonatomic, copy)      NSString    *nickname;
@property (nonatomic, copy)      NSString    *headPortrait;  //头像
@property (assign,nonatomic)     NSInteger   sex;            //性别 0男，1女
@property (nonatomic, copy)      NSString    *birthday;      //生日
@property (nonatomic, copy)      NSString    *province;      //省份
@property (nonatomic, copy)      NSString    *city;          //市
@property (nonatomic, copy)      NSString    *area;          //区
@property (nonatomic, copy)      NSString    *signature;     //签名



+ (BOOL)isLogin;
+ (void)getUserInfo;
@end
