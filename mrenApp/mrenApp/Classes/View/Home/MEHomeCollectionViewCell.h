//
//  MEHomeCollectionViewCell.h
//  mrenApp
//
//  Created by zhouen on 16/12/1.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MEAlbum;
@interface MEHomeCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) MEAlbum *album;
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@end
