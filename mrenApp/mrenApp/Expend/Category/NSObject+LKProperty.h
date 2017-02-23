//
//  NSObject+LKProperty.h
//  ChinaRegionDemo
//
//  Created by zhouen on 16/9/1.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LKProperty)
/** 
 *  此方法只为时时修改用户信息时用
 *  字典的话只会替换字典中存在的数据
 *  实体的话只会替换不为空的属性
 *  @param dataSource （字典／model）
 *
 *  @return YES/NO
 */
- (BOOL)reflectDataFromOtherObject:(NSObject*)dataSource;

/**
 *  将所有属性的值置空或0
 *
 *  @return YES
 */
- (BOOL)clearPropertyValue;
@end
