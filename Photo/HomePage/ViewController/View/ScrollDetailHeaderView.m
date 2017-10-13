//
//  ScrollDetailHeaderView.m
//  Photo
//
//  Created by malin  on 2017/10/13.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "ScrollDetailHeaderView.h"

#define kCameraManViewHeight    100
#define kCameraManViewWidth     80

@interface ScrollDetailHeaderView ()

@end

@implementation ScrollDetailHeaderView

- (id)initWithFrame:(CGRect)frame withType:(ScrollDetailType)type {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
        [self makeMasnory];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.backView];
    [self addSubview:self.titleView];
    [self addSubview:self.line1];
    [self addSubview:self.cameraManView];
    [self addSubview:self.dressManView];
    [self addSubview:self.line2];
    [self addSubview:self.line3];
    [self addSubview:self.titleLabel];
}

- (void)makeMasnory {
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(25);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.width.equalTo(@(20));
        make.height.equalTo(@(20));
    }];
    
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_backView.mas_bottom).with.offset(10);
        make.width.equalTo(@(60));
        make.height.equalTo(@(30));
    }];
    
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.height.equalTo(@(4));
        make.width.equalTo(@(ScreenWidth-80));
        make.top.equalTo(_titleView.mas_bottom).with.offset(10);
    }];
    
    if (self.type == ScrollDetailTypeAll) {
        _cameraManView.hidden = NO;
        _dressManView.hidden = NO;
        [_cameraManView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_line1.mas_bottom).with.offset(5);
            make.left.equalTo(_line1.mas_left);
            make.height.equalTo(@(kCameraManViewHeight));
            make.width.equalTo(@(kCameraManViewWidth));
        }];
        
        [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_cameraManView.mas_bottom).with.offset(5);
            make.left.equalTo(_cameraManView.mas_left);
            make.right.equalTo(_cameraManView.mas_right);
            make.height.equalTo(@(4));
        }];
        
        [_dressManView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_cameraManView);
            make.right.equalTo(_line1.mas_right);
            make.height.equalTo(@(kCameraManViewHeight));
            make.width.equalTo(@(kCameraManViewWidth));
        }];
        
        [_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_dressManView.mas_bottom).with.offset(5);
            make.left.equalTo(_dressManView.mas_left);
            make.right.equalTo(_dressManView.mas_right);
            make.height.equalTo(@(4));
        }];
    } else if (self.type == ScrollDetailTypeCameraMan) {
        _cameraManView.hidden = NO;
        [_cameraManView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_line1.mas_bottom).with.offset(5);
            make.centerX.equalTo(self);
            make.height.equalTo(@(kCameraManViewHeight));
            make.width.equalTo(@(kCameraManViewWidth));
        }];
    } else {
        _dressManView.hidden = NO;
        [_dressManView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_line1.mas_bottom).with.offset(5);
            make.centerX.equalTo(self);
            make.height.equalTo(@(kCameraManViewHeight));
            make.width.equalTo(@(kCameraManViewWidth));
        }];
    }
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_line2.mas_bottom).with.offset(10);
    }];
}

#pragma mark --- getters and setters ---
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

- (UIImageView *)titleView {
    if (!_titleView) {
        _titleView = [[UIImageView alloc] init];
        _titleView.backgroundColor = [UIColor redColor];
    }
    return _titleView;
}

- (UILabel *)line1 {
    if (!_line1) {
        _line1 = [[UILabel alloc] init];
        _line1.backgroundColor = [UIColor blackColor];
    }
    return _line1;
}

- (UIImageView *)cameraManView {
    if (!_cameraManView) {
        _cameraManView = [[UIImageView alloc] init];
        _cameraManView.hidden = YES;
    }
    return _cameraManView;
}

- (UIImageView *)dressManView {
    if (!_dressManView) {
        _dressManView = [[UIImageView alloc] init];
        _dressManView.hidden = YES;
    }
    return _dressManView;
}

- (UILabel *)line2 {
    if (!_line2) {
        _line2 = [[UILabel alloc] init];
        _line2.backgroundColor = [UIColor blackColor];
    }
    return _line2;
}

- (UILabel *)line3 {
    if (!_line3) {
        _line3 = [[UILabel alloc] init];
        _line3.backgroundColor = [UIColor blackColor];
    }
    return _line3;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"PREFERRED DISPLAY";
        _titleLabel.font = [UIFont systemFontOfSize:16];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

@end
