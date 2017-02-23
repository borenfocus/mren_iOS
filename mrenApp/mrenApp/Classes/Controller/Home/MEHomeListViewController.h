//
//  MEHomeListViewController.h
//  mrenApp
//
//  Created by zhouen on 16/12/1.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MEPhotoCategory;
@interface MEHomeListViewController : UICollectionViewController
@property (nonatomic ,strong) MEPhotoCategory *category;

- (void)initObserver;
- (void)initRefresh;

@end
