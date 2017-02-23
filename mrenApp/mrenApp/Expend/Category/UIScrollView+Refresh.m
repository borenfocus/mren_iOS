//
//  UIScrollView+Refresh.m
//  mrenApp
//
//  Created by zhouen on 16/12/19.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "UIScrollView+Refresh.h"

@implementation UIScrollView (Refresh)
- (void)stopRefresh {
    if ([self.mj_header isRefreshing]) {
        [self.mj_header endRefreshing];
    }
    if ([self.mj_footer isRefreshing]) {
        [self.mj_footer endRefreshing];
    }
}
@end
