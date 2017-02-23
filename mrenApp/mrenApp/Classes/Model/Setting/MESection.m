//
//  MESection.h
//  ReactiveCocoaDemo
//
//  Created by zhouen on 16/9/2.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MESection.h"

@implementation MESection
- (instancetype)init {
    self = [super init];
    if (self) {
        self.headerHeight = 10.f;
        self.footerHeight = 0.1f;
    }
    return self;
}
@end
