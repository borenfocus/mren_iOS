//
//  NSObject+LKProperty.m
//  ChinaRegionDemo
//
//  Created by zhouen on 16/9/1.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "NSObject+LKProperty.h"
#import <objc/runtime.h>


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@implementation NSObject (LKProperty)

- (NSArray*)propertyKeys{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:outCount];
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        MJProperty *mjProperty = [MJProperty cachedPropertyWithProperty:property];
        [keys addObject:mjProperty];
    }
    free(properties);
    return keys;
    
}



- (BOOL)reflectDataFromOtherObject:(NSObject*)dataSource{
    
    BOOL ret = NO;
    for (MJProperty *mjProperty in [self propertyKeys]) {
        NSString *key = mjProperty.name;
        if ([dataSource isKindOfClass:[NSDictionary class]]) {
            ret = ([dataSource valueForKey:key]==nil)?NO:YES;
        }else{
            ret = [dataSource respondsToSelector:NSSelectorFromString(key)];
        }
        if (ret) {
            id propertyValue = [dataSource valueForKey:key];
            //该值不为NSNULL，并且也不为nil
            if (![propertyValue isKindOfClass:[NSNull class]] && propertyValue!=nil) {
                
                [self setValue:propertyValue forKey:key];
            }
        }
    }
    
    return ret;
}
- (BOOL)clearPropertyValue{
    for (MJProperty *property in [self propertyKeys]) {
        NSString *key = property.name;
        MJPropertyType *type = property.type;
        if (type.isNumberType || type.isBoolType) {
            
            [self setValue:@0 forKey:key];
        } else {
            [self setValue:nil forKey:key];
        }
        
    }
    return YES;
}
@end

#pragma clang diagnostic pop