//
//  URLUtil.h
//  mrenApp
//
//  Created by zhouen on 17/1/9.
//  Copyright © 2017年 zhouen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLUtil : NSObject

+ (NSString *)getUrlPath:(NSString *)doPath;

+ (NSString *)getAlbumImagePath:(NSString *)doPath;

+ (NSString *)getHeaderImagePath:(NSString *)doPath;

@end
