//
//  MEAppVersion.h
//  mrenApp
//
//  Created by zhouen on 16/12/16.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AppState) {
    AppStateNormal = 1,//正常状态
    AppStateUpdate = 0,//需要强制更新
    AppStateOnline = 2 //正在上线审核
};

@interface MEAppVersion : NSObject
@property (nonatomic, copy)     NSString    *appVersion;        //版本号
@property (nonatomic, assign)   int         appState;           //状态 0、正常 1、需要强升 2、上线
@property (nonatomic, copy)     NSString    *appDevice;         //iOS android
@property (nonatomic, copy)     NSString    *appDescription;

+ (MEAppVersion *)shareInstance;
+ (void)requestAppVersion;

@end
