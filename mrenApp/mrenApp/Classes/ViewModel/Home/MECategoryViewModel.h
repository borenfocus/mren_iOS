//
//  MECategoryViewModel.h
//  mrenApp
//
//  Created by zhouen on 16/12/2.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <ReactiveViewModel/ReactiveViewModel.h>

@class MEPhotoCategory;
@interface MECategoryViewModel : RVMViewModel
@property (readonly ,nonatomic)   NSArray<MEPhotoCategory *> *categories;

@property (nonatomic, copy) void(^ errorBlock)(id error);

- (void)requestPhotoCategory_1;
@end
