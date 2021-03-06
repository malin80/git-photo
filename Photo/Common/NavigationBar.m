//
//  NavigationBar.m
//  Photo
//
//  Created by malin  on 2017/7/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "NavigationBar.h"
#import "Masonry.h"

@implementation NavigationBar

-(id)initWithFrame:(CGRect)frame withTitle:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
        _titleName = title;
        [self initView];
        [self setImmutableConstraints];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setRightButtonTitle:(NSString *)title {
    [self addSubview:self.rightButton];
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-20);
        make.centerY.equalTo(self).with.offset(5);
        make.width.equalTo(@(50));
        make.height.equalTo(@(20));
    }];
    [_rightButton setTitle:title forState:UIControlStateNormal];
}

- (void)initView {
    [self addSubview:self.titieLabel];
    [self addSubview:self.backView];
    [self addSubview:self.line];
}

- (void)setImmutableConstraints {
    [_titieLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).with.offset(5);
        make.centerX.equalTo(self);
    }];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).with.offset(5);
        make.left.equalTo(self.mas_left).with.offset(15);
        make.width.equalTo(@(20));
        make.height.equalTo(@(20));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.width.equalTo(@([[UIScreen mainScreen] bounds].size.width));
        make.height.equalTo(@(1));
    }];
}

- (void)goBack {
    if ([self.delegate respondsToSelector:@selector(goBack)]) {
        [self.delegate goBack];
        [self removeFromSuperview];
    }
}

- (void)completeClick {
    if ([self.delegate respondsToSelector:@selector(completeClick)]) {
        [self.delegate completeClick];
    }
}

#pragma mark --- getters and setters ---
- (UILabel *)titieLabel {
    if (!_titieLabel) {
        _titieLabel = [[UILabel alloc] init];
        _titieLabel.text = _titleName;
        [_titieLabel sizeToFit];
    }
    return _titieLabel;
}

- (UIImageView *)backView {
    if (!_backView) {
        _backView = [[UIImageView alloc] init];
        _backView.image = [UIImage imageNamed:@"common_back"];
        _backView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)];
        [_backView addGestureRecognizer:tap];
    }
    return _backView;
}

- (UILabel *)line {
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1.0];
    }
    return _line;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] init];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_rightButton setTitleColor:[UIColor colorR:43 G:43 B:43 alpha:1] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(completeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

@end
