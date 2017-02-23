//
//  NSUserDefaults+Extension.h
//  HSMineDemo
//
//  Created by zhouen on 16/8/12.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Extension)
+ (NSString *)stringForKey:(NSString *)defaultName;

+ (NSArray *)arrayForKey:(NSString *)defaultName;

+ (NSDictionary *)dictionaryForKey:(NSString *)defaultName;

+ (NSData *)dataForKey:(NSString *)defaultName;

+ (NSArray *)stringArrayForKey:(NSString *)defaultName;

+ (NSInteger)integerForKey:(NSString *)defaultName;

+ (float)floatForKey:(NSString *)defaultName;

+ (double)doubleForKey:(NSString *)defaultName;

+ (BOOL)boolForKey:(NSString *)defaultName;

+ (NSURL *)URLForKey:(NSString *)defaultName;

#pragma mark - WRITE FOR STANDARD

+ (void)setObject:(id)value forKey:(NSString *)defaultName;

#pragma mark - READ ARCHIVE FOR STANDARD

+ (id)unarchiveObjectForKey:(NSString *)defaultName;

#pragma mark - WRITE ARCHIVE FOR STANDARD

+ (void)setArchiveObject:(id)value forKey:(NSString *)defaultName;

+ (void)removeObjectForKey:(NSString *)defaultName;
@end
