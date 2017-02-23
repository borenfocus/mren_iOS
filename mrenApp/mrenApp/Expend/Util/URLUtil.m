//
//  URLUtil.m
//  mrenApp
//
//  Created by zhouen on 17/1/9.
//  Copyright © 2017年 zhouen. All rights reserved.
//

#import "URLUtil.h"

@implementation URLUtil
+ (NSString *)getUrlPath:(NSString *)doPath {
    if (AppVersion.appState == AppStateOnline) {
        return URL_LINE_PATH(doPath);
    }
    return URL_PATH(doPath);
}

+ (NSString *)getAlbumImagePath:(NSString *)doPath {
    if (AppVersion.appState == AppStateOnline) {
        return IMAGE_ALBUM_LINEPATH(doPath);
    }
    return IMAGE_ALBUM_PATH(doPath);
}

+ (NSString *)getHeaderImagePath:(NSString *)doPath {
    if (AppVersion.appState == AppStateOnline) {
        return IMAGE_HEADER_LINEPATH(doPath);
    }
    return IMAGE_HEADER_PATH(doPath);
}
@end
