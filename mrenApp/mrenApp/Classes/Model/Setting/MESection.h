//
//  MESection.h
//  ReactiveCocoaDemo
//
//  Created by zhouen on 16/9/2.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MESection : NSObject
@property (nonatomic, copy)      NSString    *headerTitle;
@property (nonatomic, copy)      NSString    *footerTitle;
@property (nonatomic, assign)    CGFloat     headerHeight;
@property (nonatomic, assign)    CGFloat     footerHeight;
@property (nonatomic, strong)    NSArray     *items;
@end
