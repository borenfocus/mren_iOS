//
//  MEAlbumImage.m
//  mrenApp
//
//  Created by zhouen on 16/12/5.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MEAlbumImage.h"

@implementation MEAlbumImage

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"id"
             };
    
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {};
@end
