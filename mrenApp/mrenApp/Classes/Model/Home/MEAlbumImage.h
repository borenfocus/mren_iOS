//
//  MEAlbumImage.h
//  mrenApp
//
//  Created by zhouen on 16/12/5.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEAlbumImage : NSObject
@property (nonatomic, assign) long ID;
@property (nonatomic, copy) NSString *uuid;
//相册ID
@property (nonatomic, copy) NSString *photoUuid;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, assign) NSInteger imageWidth;
@property (nonatomic, assign) NSInteger imageHeight;
@property (nonatomic, assign) long imageSize;
@property (nonatomic, assign) long praisedNumber;
@property (nonatomic, assign) NSInteger state;
@end
