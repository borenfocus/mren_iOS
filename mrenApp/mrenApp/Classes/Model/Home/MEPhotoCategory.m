//
//  MEPhotoCategory.m
//  mrenApp
//
//  Created by zhouen on 16/12/2.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MEPhotoCategory.h"

@implementation MEPhotoCategory
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {};

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        [self mj_decode:decoder];
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder {
    [self mj_encode:encoder];
}
@end
