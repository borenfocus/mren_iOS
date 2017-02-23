//
//  MEPhotoCategory.h
//  mrenApp
//
//  Created by zhouen on 16/12/2.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEPhotoCategory : NSObject<NSCoding>

@property (nonatomic, copy)     NSString    *cid;
@property (nonatomic, copy)     NSString    *name;
@property (nonatomic, assign)   NSInteger   state;
@property (nonatomic, assign)   NSInteger   sortId;

@end
