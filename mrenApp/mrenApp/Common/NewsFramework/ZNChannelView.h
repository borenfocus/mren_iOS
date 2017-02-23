//
//  ChannelView.h
//  NewsGuide
//
//  Created by zhouen on 16/9/9.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CHANNEL_MARGIN   30

@class ZNChannelView;
@protocol  ChannelViewDelegate<NSObject>

-(void)channelView:(ZNChannelView *)channelView didSelectIndex:(NSUInteger)index;

@end
@interface ZNChannelView : UIView

@property (strong, nonatomic, readonly) UIColor *selectColor;

@property (strong, nonatomic) NSArray <NSString *>*channels;

@property (weak, nonatomic) id<ChannelViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame
                  selectColor:(UIColor *)selectColor;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
- (void)scrollToPositionByIndex:(NSUInteger)index;

@end
