//
//  MEHomeCollectionViewCell.m
//  mrenApp
//
//  Created by zhouen on 16/12/1.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MEHomeCollectionViewCell.h"
#import "MEAlbum.h"

@interface MEHomeCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation MEHomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.contentView.backgroundColor=[self randomColor];
}

- (void)setAlbum:(MEAlbum *)album {
    _album = album;
    [_coverImage sd_setImageWithURL:[NSURL URLWithString:[URLUtil getAlbumImagePath:_album.imageUrl]] placeholderImage:nil];
    _titleLabel.text = _album.title;
}


-(UIColor *) randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}


@end
