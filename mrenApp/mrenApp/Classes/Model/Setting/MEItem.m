//
//  MEItem.h
//  ReactiveCocoaDemo
//
//  Created by zhouen on 16/9/2.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MEItem.h"

@implementation MEItem

+ (MEItem *)itemWithText:(NSString *)text actionBlock:(void (^)(void))actionBlock {
    return [MEItem itemWithText:text imageName:@"" actionBlock:actionBlock];
}

+ (MEItem *)itemWithText:(NSString *)text detailText:(NSString *)detailText actionBlock:(void (^)(void))actionBlock {
    return [MEItem itemWithText:text detailText:detailText imageName:nil detailImage:nil actionBlock:actionBlock];

}

+ (MEItem *)itemWithText:(NSString *)text imageName:(NSString *)imageName actionBlock:(void (^)(void))actionBlock {
    return [MEItem itemWithText:text detailText:nil imageName:imageName detailImage:nil actionBlock:actionBlock];
}

+ (MEItem *)itemWithText:(NSString *)text detailImage:(NSString *)detailimage actionBlock:(void (^)(void))actionBlock {
    return [MEItem itemWithText:text detailText:nil imageName:nil detailImage:detailimage actionBlock:actionBlock];
}

+ (MEItem *)itemWithText:(NSString *)text detailText:(NSString *)detailText imageName:(NSString *)imageName detailImage:(NSString *)detailImage actionBlock:(void (^)(void))actionBlock {
    MEItem *item = [[MEItem alloc] init];
    item.text = text;
    item.detailText = detailText;
    item.image = imageName ? [UIImage imageNamed:imageName] : nil;
    item.detailImage = detailImage ? [UIImage imageNamed:detailImage] : nil;
    item.execute = actionBlock;
    item.accessoryType = ItemAccessoryTypeDisclosureIndicator;
    return item;
}

@end
