//
//  LKUpdateSexSheet.h
//  VChat
//
//  Created by zhouen on 16/8/31.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEUpdateSexSheet : UIView
@property (copy,nonatomic) void(^sexBlock)(int sex);
@property (copy,nonatomic) NSString *sex;
@end
