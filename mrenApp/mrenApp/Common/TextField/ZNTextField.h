//
//  ZNTextField.h
//  HSMineDemo
//
//  Created by zhouen on 16/8/15.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZNTextField;
@protocol ZNTextFieldDelegate <NSObject>

- (void)textFieldDidChange:(ZNTextField *)textField;

- (BOOL)textField:(ZNTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end

@interface ZNTextField : UIView
@property (nonatomic, weak) id<ZNTextFieldDelegate> delegate;
@property (nonatomic, copy) NSString *leftImage;
@property (nonatomic, copy) NSString *rightImage;
@property (nonatomic, copy) NSString *rightSelectedImage;
@property (nonatomic, copy) NSString *jText;
@property (nonatomic, assign) NSInteger fonSize;
@property (nonatomic, copy) NSString *placeHolder;
@property (nonatomic, assign) BOOL secureTextEntry;
@property (nonatomic, assign) NSInteger maxLength;
@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, assign) BOOL EnableEditing;
@end
