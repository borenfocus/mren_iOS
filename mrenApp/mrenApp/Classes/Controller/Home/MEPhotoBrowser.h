//
//  MEPhotoBrowser.h
//  mrenApp
//
//  Created by zhouen on 16/12/7.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "IDMPhotoBrowser.h"
#import "IDMPhotoBrowser.h"
@class IDMPhotoBrowser ,MEAlbum;
@interface MEPhotoBrowser : IDMPhotoBrowser
@property (nonatomic, strong) MEAlbum *album;
@property (nonatomic, strong) UINavigationController *nav;
@end
