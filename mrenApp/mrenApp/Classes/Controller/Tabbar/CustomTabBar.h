//
//  CustomTabBar.h
//  tabbar
//
//  Created by zhouen on 13/2/20.
//  Copyright © 2013年 zn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CenterBtnClick)();

@interface CustomTabBar : UITabBar
@property (nonatomic, copy) CenterBtnClick clickBlock;
@end

