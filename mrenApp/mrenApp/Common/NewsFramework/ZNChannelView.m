//
//  ChannelView.m
//  NewsGuide
//
//  Created by zhouen on 16/9/9.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "ZNChannelView.h"
#import "ZNChannelLabel.h"

@interface ZNChannelView ()

@property (nonatomic ,strong) UIScrollView      *channelScrollView;
@property (nonatomic ,strong) UIView            *underline;

@property (nonatomic ,strong) UILabel           *selectLabel;
@property (nonatomic ,strong) UIColor           *selectColor;
@property (nonatomic ,strong) NSMutableArray    *channelLabels;

@end

@implementation ZNChannelView

#pragma mark ------ Lifecycle

- (instancetype)initWithFrame:(CGRect)frame
                  selectColor:(UIColor *)selectColor {
    
    
    if (self = [super initWithFrame:frame]) {
        
        [self p_initSelf];
        _selectColor = selectColor;
    }
    
    return self;
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _selectColor = [UIColor blueColor];
        [self p_initSelf];
        
    }
    return self;
}

#pragma mark ------ setter getter

- (void)setChannels:(NSArray <NSString *>*)channels{
    _channels = channels;
    
    [_channelScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_channelScrollView setContentOffset:CGPointZero];
    _channelLabels = [NSMutableArray arrayWithCapacity:_channels.count];
    CGFloat margin = CHANNEL_MARGIN;
    CGFloat x = 0;
    CGFloat h = _channelScrollView.bounds.size.height;
    int i = 0;
    
    for (NSString *channel in _channels) {
        ZNChannelLabel *label = [ZNChannelLabel channelLabelWithTitle:channel];
        label.selectedColor = self.selectColor;
        label.frame = CGRectMake(x, 0, label.width +margin, h);
        [_channelScrollView addSubview:label];
        [self.channelLabels addObject:label];
        
        x += label.bounds.size.width;
        label.tag = i;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(p_labelClick:)]];
        
        if (i == 0) {
            _selectLabel = label;
            label.textColor = _selectColor?:[UIColor blueColor];
            _underline = [[UIView alloc] initWithFrame:CGRectMake(0, self.channelScrollView.height - 4, label.textWidth, 4)];
            _underline.centerX = label.centerX;
            _underline.backgroundColor = _selectColor?:[UIColor blueColor];
            [_channelScrollView addSubview:_underline];
        }
        
        i++;
    }
    _channelScrollView.contentSize = CGSizeMake(x, 0);
    
    [self p_scrollToPositionByIndex:0];
}

#pragma mark ------ Public

- (void)scrollToPositionByIndex:(NSUInteger)index {
    [self p_scrollToPositionByIndex:index animated:NO];
}

/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scale = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (scale < 0) {return;} // 防止在最左侧的时候，再滑，下划线位置会偏移，颜色渐变会混乱。
    
    NSUInteger leftIndex = (int)scale;
    NSUInteger rightIndex = leftIndex + 1;
    if (rightIndex >= self.channels.count) {  // 防止滑到最右，再滑，数组越界，从而崩溃
        rightIndex = self.channels.count - 1;
    }
    
    CGFloat scaleRight = scale - leftIndex;
    CGFloat scaleLeft  = 1 - scaleRight;
    
    if (scaleLeft == 1 && scaleRight == 0) {
        return;
    }
    
    ZNChannelLabel *labelLeft  = self.channelLabels[leftIndex];
    ZNChannelLabel *labelRight = self.channelLabels[rightIndex];
    
    labelLeft.scale  = scaleLeft;
    labelRight.scale = scaleRight;
    

    _underline.centerX = labelLeft.centerX   + (labelRight.centerX   - labelLeft.centerX)   * scaleRight;
    _underline.width   = labelLeft.textWidth + (labelRight.textWidth - labelLeft.textWidth) * scaleRight;
}

/** 手指点击smallScrollView */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / scrollView.width;
    // 滚动标题栏到中间位置
    [self p_scrollToPositionByIndex:index];
}


#pragma mark ------ Private

- (void)p_initSelf {
    
    self.channelScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:_channelScrollView];
    [self.channelScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    _channelScrollView.showsHorizontalScrollIndicator = NO;
    _channelScrollView.bounces = NO;

    
}

- (void)p_scrollToPositionByIndex:(NSUInteger)index animated:(BOOL)animated{
    if (!_channelLabels || _channelLabels.count == 0 || index >= _channelLabels.count) {
        return;
    }
    ZNChannelLabel *titleLable = self.channelLabels[index];
    CGFloat offsetx   =  titleLable.center.x - _channelScrollView.width * 0.5;
    CGFloat offsetMax = _channelScrollView.contentSize.width - _channelScrollView.width;
    
    // 在最左和最右时，标签没必要滚动到中间位置。
    if (offsetx < 0)		 {offsetx = 0;}
    if (offsetx > offsetMax) {offsetx = offsetMax;}
    if (_channelScrollView.contentSize.width > _channelScrollView.width) {
        [_channelScrollView setContentOffset:CGPointMake(offsetx, 0) animated:animated];
    }
    
    _selectLabel.textColor = [UIColor blackColor];
    titleLable.textColor = _selectColor?:[UIColor blueColor];
    _selectLabel = titleLable;
    
    // 下划线滚动并着色
    if (animated) {
        [UIView animateWithDuration:0.5 animations:^{
            _underline.width = titleLable.textWidth;
            _underline.centerX = titleLable.centerX;
        }];
    } else {
        _underline.width = titleLable.textWidth;
        _underline.centerX = titleLable.centerX;
    }
}

- (void)p_scrollToPositionByIndex:(NSUInteger)index{
    [self p_scrollToPositionByIndex:index animated:YES];
}


- (void)p_labelClick:(UITapGestureRecognizer *)tap{
    ZNChannelLabel *label = (ZNChannelLabel *)tap.view;
    if (_delegate && [_delegate respondsToSelector:@selector(channelView:didSelectIndex:)]) {
        [_delegate channelView:self didSelectIndex:label.tag];
    }
    [self p_scrollToPositionByIndex:label.tag];
}
@end
