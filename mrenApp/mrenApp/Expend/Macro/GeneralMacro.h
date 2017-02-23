//
//  Macro.h
//  fate
//
//  Created by 周恩 on 15/10/26.
//  Copyright © 2015年 zhouen. All rights reserved.
//

#ifndef GeneralMacro_h
#define GeneralMacro_h

/*********************颜色相关的宏定义 begin***********************/
//十六进制颜色
#define HEX_COLORA(rgbValue ,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define HEX_COLOR(rgbValue) HEX_COLORA(rgbValue,1.0)


// 获取RGB颜色
#define UIColorFromRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define UIColorFromRGB(r,g,b) RGBA(r,g,b,1.0f)

//项目全局背景颜色    ededed   #E9E9E9  0xE9E8ED UIColorFrom0xRGB(0xE9E9EC )
#define MAIN_COLOR  HEX_COLOR(0xEFEFF4)

#define THEME_COLOR HEX_COLOR(0xFF82AB)

/*********************颜色相关的宏定义 end***********************/


#define isIphone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define isIphone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define isIphone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1920, 1080), [[UIScreen mainScreen] currentMode].size) ) : NO)




/*********************尺寸相关的宏定义 begin***********************/
//屏幕宽高
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//状态栏高度
#define kLuckStatusHeight  ([UIApplication sharedApplication].statusBarFrame.size.height)
//状态栏＋导航栏高度
#define kLuckNavStatusHeight (44 + kLuckStatusHeight)
//除去状态栏 导航栏 tabbar的高度
#define kLuckCenterViewHeight (kLuckScreenHeight - kLuckNavStatusHeight)
//除去状态栏 导航栏的高度
#define kLuckCenterViewHeightContainsTabbar (kLuckScreenHeight - kLuckNavStatusHeight)


/*********************尺寸相关的宏定义 end***********************/






/*********************手机系统相关的宏定义 begin***********************/
#define SYSTEM_VERSION [[UIDevice currentDevice].systemVersion floatValue]
/*********************手机系统相关的宏定义 end***********************/



//状态栏隐藏显示 快捷方法
#define UITabBarHidden(YES) self.tabBarController.tabBar.hidden = YES



//当前网络状态
#define IS_NET [HttpRequest shareInstance].isNetworkConnected

#define AppWindow [[UIApplication sharedApplication].delegate window]

#endif /* Macro_h */
