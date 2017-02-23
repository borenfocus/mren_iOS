//
//  MEAppVersion.h
//  mrenApp
//
//  Created by zhouen on 16/12/16.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "HttpRequest.h"

@interface MEAppVersionRequest : HttpRequest


/**
 获取app版本信息

 @param appVersion app版本号
 @return --
 */
+ (RACSignal *)getAppVerisonInfo;
@end
