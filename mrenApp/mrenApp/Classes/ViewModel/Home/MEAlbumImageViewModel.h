//
//  MEAlbumImageViewModel.h
//  mrenApp
//
//  Created by zhouen on 16/12/5.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <ReactiveViewModel/ReactiveViewModel.h>
@class MEAlbumImage;
@interface MEAlbumImageViewModel : RVMViewModel
@property (nonatomic, readonly) NSArray<MEAlbumImage *> *images;
- (instancetype)initWithPhotoUuid:(NSString *)photoUuid;
@end
