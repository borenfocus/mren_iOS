//
//  LUSER_INFO.m
//  VChat
//
//  Created by zhouen on 16/8/31.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MEUser.h"
#import "NSObject+LKProperty.h"
#import "MEUserRequest.h"


#define USER_INFO @"MEUser_user_info"

@implementation MEUser
+ (MEUser *)userDefaults
{
    static MEUser *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[self alloc] init];
        
        id obj = [NSUserDefaults unarchiveObjectForKey:USER_INFO];
        if (obj) {
            [user reflectDataFromOtherObject:obj];
        }
        
    });
    return user;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self p_initializeObserver];
    }
    return self;
}
- (void)p_initializeObserver {
    int skip = 1;
    
    //uid = 0 token=nil 未登录不需要归档
    [[[[RACObserve(self, uuid) distinctUntilChanged] skip:skip]
     filter:^BOOL(id value) {
         return value && [value length]> 0;
    }]
     subscribeNext:^(id x) {
         [NSUserDefaults setArchiveObject:self forKey:USER_INFO];
    }];
    
    [[[[RACObserve(self, token) distinctUntilChanged] skip:skip]
     filter:^BOOL(NSString *value) {
         return value;
     }]
     subscribeNext:^(id x) {
         [NSUserDefaults setArchiveObject:self forKey:USER_INFO];
     }];
    
    [[[[RACObserve(self, headPortrait) distinctUntilChanged] skip:skip]
     filter:^BOOL(id value) {
         return _uuid && _uuid.length;
     }]
     subscribeNext:^(id x) {
         [NSUserDefaults setArchiveObject:self forKey:USER_INFO];
     }];
    [[[[RACObserve(self, nickname) distinctUntilChanged] skip:skip]
     filter:^BOOL(id value) {
         return _uuid && _uuid.length;
     }]
     subscribeNext:^(id x) {
         [NSUserDefaults setArchiveObject:self forKey:USER_INFO];
     }];
    [[[[RACObserve(self, sex) distinctUntilChanged] skip:skip]
     filter:^BOOL(id value) {
         return _uuid && _uuid.length;
     }]
     subscribeNext:^(id x) {
         [NSUserDefaults setArchiveObject:self forKey:USER_INFO];
     }];
    [[[[RACObserve(self, birthday) distinctUntilChanged] skip:skip]
     filter:^BOOL(id value) {
         return _uuid && _uuid.length;
     }]
     subscribeNext:^(id x) {
         [NSUserDefaults setArchiveObject:self forKey:USER_INFO];
     }];
    [[[[RACObserve(self, province) distinctUntilChanged] skip:skip]
     filter:^BOOL(id value) {
         return _uuid && _uuid.length;
     }]
     subscribeNext:^(id x) {
         [NSUserDefaults setArchiveObject:self forKey:USER_INFO];
     }];
    [[[[RACObserve(self, city) distinctUntilChanged] skip:skip]
     filter:^BOOL(id value) {
         return _uuid && _uuid.length;
     }]
     subscribeNext:^(id x) {
         [NSUserDefaults setArchiveObject:self forKey:USER_INFO];
     }];
    [[[[RACObserve(self, area) distinctUntilChanged] skip:skip]
     filter:^BOOL(id value) {
         return _uuid && _uuid.length;
     }]
     subscribeNext:^(id x) {
         [NSUserDefaults setArchiveObject:self forKey:USER_INFO];
     }];
    [[[[RACObserve(self, signature) distinctUntilChanged] skip:skip]
     filter:^BOOL(id value) {
         return _uuid && _uuid.length;
     }]
     subscribeNext:^(id x) {
         [NSUserDefaults setArchiveObject:self forKey:USER_INFO];
     }];
    
}

- (void)updateUserByDict:(NSDictionary *)dict {
    [self reflectDataFromOtherObject:dict];
}

- (void)clearGlobalUser {
    [self clearPropertyValue];
    [NSUserDefaults removeObjectForKey:USER_INFO];
}


- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        [self mj_decode:decoder];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder {
    [self mj_encode:encoder];
}

+ (BOOL)isLogin {
    MEUser *user = [MEUser userDefaults];
    return user.uuid == 0 ? NO : YES ;
}

+ (void)getUserInfo {
    if ([self isLogin]) {
        [[MEUserRequest getUserInfo:[MEUser userDefaults].uuid] subscribeNext:^(id x) {
            [[MEUser userDefaults] updateUserByDict:x];
        }];
    }
}

@end
