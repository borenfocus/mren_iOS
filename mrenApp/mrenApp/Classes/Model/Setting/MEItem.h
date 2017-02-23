//
//  ItemModel.h
//  ReactiveCocoaDemo
//
//  Created by zhouen on 16/9/2.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ItemAccessoryType) {
    ItemAccessoryTypeNone,
    ItemAccessoryTypeDisclosureIndicator,
    ItemAccessoryTypeSwitch,
    ItemAccessoryTypeCustomView,
};


@interface MEItem : NSObject
@property (nonatomic, copy)      NSString    *text;
@property (nonatomic, copy)      NSString    *detailText;

@property (nonatomic, strong)    UIImage     *image;
@property (nonatomic, strong)    UIImage     *detailImage;
@property (nonatomic, copy)      NSString    *detailImageUrl;

@property (nonatomic, assign)    BOOL    isOn;//switch状态

//type 为ItemAccessoryTypeCustomView 才会生效
@property (nonatomic, strong)   UIView      *customView;
@property (nonatomic, assign)   ItemAccessoryType   accessoryType;

@property (nonatomic, copy) void (^execute)(); /**<      点击item要执行的代码*/
@property (nonatomic, copy) void (^switchValueChanged)(BOOL isOn);

+ (MEItem *)itemWithText:(NSString *)text
             actionBlock:(void (^)(void))actionBlock;

+ (MEItem *)itemWithText:(NSString *)text
              detailText:(NSString *)detailText
             actionBlock:(void (^)(void))actionBlock;

+ (MEItem *)itemWithText:(NSString *)text
                imageName:(NSString *)imageName
             actionBlock:(void(^)(void))actionBlock;

+ (MEItem *)itemWithText:(NSString *)text
             detailImage:(NSString *)imageName
             actionBlock:(void (^)(void))actionBlock;

@end
