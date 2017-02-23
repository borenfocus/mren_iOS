//
//  LKActionSheet.h
//  vchat
//
//  Created by zhouen on 16/8/19.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MEActionSheet;

@protocol MEActionSheetDelegate <NSObject>

@optional

-(void)actionSheetCancel:(MEActionSheet *)actionSheetCancel;

-(void)actionSheet:(MEActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface MEActionSheet : UIView

@property (nonatomic, strong)NSString *title;

@property (nonatomic, strong)NSString *cancelButtonTitle;

@property (nonatomic, weak) id<MEActionSheetDelegate>delegate;

-(id)initWithTitle:(NSString *)title delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle, ... NS_REQUIRES_NIL_TERMINATION;

-(void)show;

-(void)hide;

-(void)setTitleColor:(UIColor *)titleColor fontSize:(CGFloat)fontSize;

-(void)setButtonTitleColor:(UIColor *)buttonTitleColor fontSize:(CGFloat)fontSize;

-(void)setButtonTitleColor:(UIColor *)buttonTitleColor fontSize:(CGFloat)fontSize atIndex:(int)atIndex;

-(void)setCancelButtonTitleColor:(UIColor *)cancelButtonTitleColor fontSize:(CGFloat)fontSize;

@end
