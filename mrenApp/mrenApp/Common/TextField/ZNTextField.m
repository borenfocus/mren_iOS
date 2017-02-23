//
//  PTETTextField.m
//  HSMineDemo
//
//  Created by zhouen on 16/8/15.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "ZNTextField.h"
#define MARGINWIDTH 5

@interface ZNTextField()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView  *leftView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIView  *rightView;
@property (nonatomic, strong) UIButton *rightButton;



@end

@implementation ZNTextField
@synthesize jText = _jText;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.maxLength = 100;
        self.EnableEditing = YES;
        self.backgroundColor = HEX_COLOR(0xf7f7f7);
//        self.layer.cornerRadius = 4;
//        self.layer.borderWidth = 0.5;
//        self.layer.borderColor = HEX_COLOR(0xcacaca).CGColor;
        
        _textField = [[UITextField alloc] init];
        _textField.textColor = HEX_COLOR(0x909090);
        _textField.font = [UIFont systemFontOfSize:14];
        _textField.autocorrectionType = UITextAutocorrectionTypeNo;
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _textField.delegate = self;
        [self addSubview:_textField];
        _textField.clearButtonMode = UITextFieldViewModeAlways;
        _leftView = [[UIView alloc] init];
        [self addSubview:_leftView];
        
        _rightView = [[UIView alloc] init];
        [self addSubview:_rightView];
        
    }
    return self;
}

- (void)setLeftImage:(NSString *)leftImage
{
    _leftImage = leftImage;
    
    [self setNeedsLayout];
}

- (void)setRightImage:(NSString *)rightImage
{
    _rightImage = rightImage;
    
    UIImage *image = [UIImage imageNamed:_rightImage];
    
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton addTarget:self action:@selector(rightButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [_rightView addSubview:_rightButton];
    }
    [_rightButton setImage:image forState:UIControlStateNormal];
    
    [self setNeedsLayout];
}

- (void)setRightSelectedImage:(NSString *)rightSelectedImage
{
    _rightSelectedImage = rightSelectedImage;
    UIImage *image = [UIImage imageNamed:_rightSelectedImage];
    
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton addTarget:self action:@selector(rightButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [_rightView addSubview:_rightButton];
    }
    [_rightButton setImage:image forState:UIControlStateSelected];
    [self setNeedsLayout];
}

- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = placeHolder;
    
    if (_textField) {
        _textField.attributedPlaceholder = [[NSAttributedString alloc]
                                            initWithString:placeHolder
                                            attributes:@{NSForegroundColorAttributeName:HEX_COLOR(0x909090)}];
    }
    [self layoutIfNeeded];
}

- (void)setEnableEditing:(BOOL)EnableEditing
{
    _EnableEditing = EnableEditing;
    if (_textField) {
        _textField.enabled = EnableEditing;
    }
}

- (void)rightButtonClickAction:(id)sender
{
    
    UIButton *button = (UIButton *)sender;
    
    button.selected = !button.selected;
    
    if (button.selected) {
        self.textField.secureTextEntry = NO;
    }else{
        self.textField.secureTextEntry = YES;
    }
}


- (void)setJText:(NSString *)jText
{
    _jText = jText;
    if (_textField) {
        _textField.text = jText;
    }
    
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry
{
    _secureTextEntry = secureTextEntry;
    
    if (_textField) {
        _textField.secureTextEntry = secureTextEntry;
    }
}

- (NSString *)jText
{
    
    return _textField.text;
    
}

- (void)setFonSize:(NSInteger)fonSize
{
    _fonSize = fonSize;
    if (_textField) {
        _textField.font = [UIFont systemFontOfSize:fonSize];
    }
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType
{
    _keyboardType = keyboardType;
    _textField.keyboardType = keyboardType;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect = CGRectZero;
    rect.size.height = self.frame.size.height;
    if (!_leftImage) {
        rect.size.width = MARGINWIDTH;
    }else{
        rect.size.width = 40;
        
        if (!_leftImageView) {
            UIImage *image = [UIImage imageNamed:_leftImage];
            _leftImageView = [[UIImageView alloc] initWithImage:image];
            [_leftView addSubview:_leftImageView];
        }
        CGRect re = CGRectZero;
        re.size = _leftImageView.image.size;
        re.origin.x = (rect.size.width - re.size.width) / 2;
        re.origin.y = (self.frame.size.height - re.size.height) / 2;
        _leftImageView.frame = re;
    }
    
    _leftView.frame = rect;
    
    if (!_rightButton) {
        rect.size.width = MARGINWIDTH;
    }else{
        rect.size.width = 40;
        CGRect re = CGRectZero;
        re.size = rect.size;
        _rightButton.frame = re;
        
    }
    rect.origin.x = self.frame.size.width - rect.size.width;
    _rightView.frame = rect;
    
    rect.size.width = self.frame.size.width - _leftView.frame.size.width - _rightView.frame.size.width;
    rect.origin.x = _leftView.frame.origin.x + _leftView.frame.size.width;
    _textField.frame = rect;
    
    
}

- (void)textFieldDidChange:(UITextField *) textField{
    if (textField.text.length > _maxLength) {
        textField.text = [textField.text substringToIndex:_maxLength];
    }
    if ([self.delegate respondsToSelector:@selector(textFieldDidChange:)]) {
        return  [self.delegate textFieldDidChange:self];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return  [self.delegate textField:self shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

@end
