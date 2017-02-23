//
//  UtilsMacro.h
//  mrenApp
//
//  Created by zhouen on 16/12/2.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#ifndef UtilsMacro_h
#define UtilsMacro_h
#import "AppDelegate.h"

/*
 判断为空
 */
#define isNil(array) ((!array || array.count == 0) ? YES:NO)

//xib快捷
//#define UINib(name)[UINib nibWithNibName:name bundle:nil]

#define UINib(ClassName) [UINib nibWithNibName:NSStringFromClass([ClassName class]) bundle:nil]

//字体
#define UIFont(size) [UIFont systemFontOfSize:size]


#define AllowRotation(bool) [(AppDelegate *)[UIApplication sharedApplication].delegate setAllowRotation:bool]
#endif /* UtilsMacro_h */
