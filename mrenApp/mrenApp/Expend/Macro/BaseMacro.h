//
//  BaseMacro.h
//  VChat
//
//  Created by zhouen on 16/6/27.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#ifndef BaseMacro_h
#define BaseMacro_h

#import "GeneralMacro.h"
#import "URLMacro.h"
#import "UtilsMacro.h"
#import "VendorMacro.h"
#import "UserDefaultsMacro.h"


#ifdef DEBUG
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif


#endif /* BaseMacro_h */
