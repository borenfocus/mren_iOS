//
//  LKUpdateNameViewController.h
//  vchat
//
//  Created by zhouen on 16/8/17.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEUpdateNameViewController : UIViewController
@property (copy,nonatomic) void(^saveBlock)(NSString *nickName);         //保存
@end
