//
//  MEAppVersion.m
//  mrenApp
//
//  Created by zhouen on 16/12/16.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MEAppVersion.h"
#import "NSObject+LKProperty.h"
#import "MEAppVersionRequest.h"

#define VERSION_INFO @"version_info"

@implementation MEAppVersion
+ (MEAppVersion *)shareInstance
{
    static MEAppVersion *version = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        version = [[self alloc] init];
        version.appState = AppStateOnline;
        
//        id obj = [NSUserDefaults unarchiveObjectForKey:VERSION_INFO];
        
    });
    return version;
}

+ (void)requestAppVersion {
    MEAppVersion *version = [MEAppVersion shareInstance];
    [[[[MEAppVersionRequest getAppVerisonInfo] filter:^BOOL(id value) {
        return value;
    }] map:^id(id value) {
        return [MEAppVersion mj_objectWithKeyValues:value];
    }] subscribeNext:^(id x) {
        [version reflectDataFromOtherObject:x];
    }];

}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}
@end
