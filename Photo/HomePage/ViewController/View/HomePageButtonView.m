//
//  HomePageButtonView.m
//  Photo
//
//  Created by malin  on 2017/7/25.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "HomePageButtonView.h"
#import "Masonry.h"

#define kButtonWidth        40.0f
#define kButtonHeitht       60.0f
#define kButtonDistance     ([[UIScreen mainScreen] bounds].size.width - kButtonWidth*5+20)/3
#define kTextColor          [UIColor colorWithRed:152/255.0 green:153/255.0 blue:152/255.0 alpha:1.0]

@implementation HomePageButtonView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
        [self setImmutableConstraints];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.cameraButton];
    [self addSubview:self.weddingButton];
    [self addSubview:self.weddingLabel];
    [self addSubview:self.carButton];
    [self addSubview:self.flowerButton];
    [self addSubview:self.flowerLabel];
    [self addSubview:self.hotelButton];
    [self addSubview:self.hotelLabel];
    [self addSubview:self.videoButton];
    [self addSubview:self.videoLabel];
    [self addSubview:self.clothButton];
    [self addSubview:self.clothLabel];
    [self addSubview:self.moreButton];
}

- (void)setImmutableConstraints {
    [_cameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.top.equalTo(self.mas_top).with.offset(10);
        make.width.equalTo(@(kButtonWidth));
        make.height.equalTo(@(kButtonHeitht));
    }];
    
    [_weddingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_cameraButton.mas_right).with.offset(kButtonDistance);
        make.top.equalTo(_cameraButton);
        make.width.equalTo(@(kButtonWidth));
        make.height.equalTo(@(kButtonHeitht));
    }];
    
    [_weddingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_weddingButton);
        make.bottom.equalTo(_weddingButton.mas_bottom);
    }];
    
    [_clothButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_weddingButton.mas_right).with.offset(kButtonDistance);
        make.top.equalTo(_cameraButton);
        make.width.equalTo(@(kButtonWidth));
        make.height.equalTo(@(kButtonHeitht));
    }];
    
    [_clothLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_clothButton);
        make.bottom.equalTo(_clothButton.mas_bottom);
    }];

    [_hotelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cameraButton);
        make.left.equalTo(_clothButton.mas_right).with.offset(kButtonDistance);
        make.width.equalTo(@(kButtonWidth));
        make.height.equalTo(@(kButtonHeitht));
    }];
    
    [_hotelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_hotelButton);
        make.bottom.equalTo(_hotelButton.mas_bottom);
    }];

    [_carButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cameraButton.mas_bottom).with.offset(20);
        make.left.equalTo(_cameraButton);
        make.width.equalTo(@(kButtonWidth));
        make.height.equalTo(@(kButtonHeitht));
    }];
    
    [_videoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_carButton);
        make.left.equalTo(_carButton.mas_right).with.offset(kButtonDistance);
        make.width.equalTo(@(kButtonWidth));
        make.height.equalTo(@(kButtonHeitht));
    }];
    
    [_videoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_videoButton);
        make.bottom.equalTo(_videoButton.mas_bottom);
    }];
    
    [_flowerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_videoButton.mas_right).with.offset(kButtonDistance);
        make.top.equalTo(_carButton);
        make.width.equalTo(@(kButtonWidth));
        make.height.equalTo(@(kButtonHeitht));
    }];
    
    [_flowerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_flowerButton);
        make.bottom.equalTo(_flowerButton.mas_bottom);
    }];
    
    [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_carButton);
        make.left.equalTo(_flowerButton.mas_right).with.offset(kButtonDistance);
        make.width.equalTo(@(kButtonWidth));
        make.height.equalTo(@(kButtonHeitht));
    }];
}

#pragma mark --- button method ---
- (void)touchCameraButton {
    if ([self.delegate respondsToSelector:@selector(touchCameraButton)]) {
        [self.delegate touchCameraButton];
    }
}

- (void)touchWediingButton {
    if ([self.delegate respondsToSelector:@selector(touchWeddingButton)]) {
        [self.delegate touchWeddingButton];
    }
}

- (void)touchCarButton {
    
}

- (void)touchFlowerButton {
    
}

- (void)touchHotelButton {
    
}

- (void)touchVideoButton {
    
}

- (void)touchClothButton {
    if ([self.delegate respondsToSelector:@selector(touchClothButton)]) {
        [self.delegate touchClothButton];
    }
}

- (void)touchMoreButton {
    
}

#pragma mark --- getters and setters ---
- (UIButton *)cameraButton {
    if (!_cameraButton) {
        //    UIKIT_STATIC_INLINE UIEdgeInsets UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {

        _cameraButton = [[UIButton alloc] init];
        [_cameraButton addTarget:self action:@selector(touchCameraButton) forControlEvents:UIControlEventTouchUpInside];
        
        [_cameraButton setTitle:@"摄影" forState:UIControlStateNormal];
        [_cameraButton setTitleEdgeInsets:UIEdgeInsetsMake(45, -45, 0.0, 0.0)];
        [_cameraButton setTitleColor:kTextColor forState:UIControlStateNormal];
        _cameraButton.titleLabel.font = [UIFont systemFontOfSize:14];

        [_cameraButton setImage:[UIImage imageNamed:@"homepage_camera"] forState:UIControlStateNormal];
        [_cameraButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 20, 0.0)];
    }
    return _cameraButton;
}

- (UIButton *)weddingButton {
    if (!_weddingButton) {
        _weddingButton = [[UIButton alloc] init];
        [_weddingButton addTarget:self action:@selector(touchWediingButton) forControlEvents:UIControlEventTouchUpInside];
        [_weddingButton setImage:[UIImage imageNamed:@"homepage_wedding"] forState:UIControlStateNormal];
        [_weddingButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 20, 0.0)];
    }
    return _weddingButton;
}

- (UILabel *)weddingLabel {
    if (!_weddingLabel) {
        _weddingLabel = [[UILabel alloc] init];
        _weddingLabel.text = @"婚礼策划";
        _weddingLabel.textColor = kTextColor;
        _weddingLabel.font = [UIFont systemFontOfSize:14];
        [_weddingLabel sizeToFit];
    }
    return _weddingLabel;
}


- (UIButton *)carButton {
    if (!_carButton) {
        _carButton = [[UIButton alloc] init];
        [_carButton addTarget:self action:@selector(touchCarButton) forControlEvents:UIControlEventTouchUpInside];
        
        [_carButton setTitle:@"婚车" forState:UIControlStateNormal];
        [_carButton setTitleEdgeInsets:UIEdgeInsetsMake(45, -45, 0.0, 0.0)];
        [_carButton setTitleColor:kTextColor forState:UIControlStateNormal];
        _carButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_carButton setImage:[UIImage imageNamed:@"homepage_car"] forState:UIControlStateNormal];
        [_carButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 20, 0.0)];
    }
    return _carButton;
}


- (UIButton *)flowerButton {
    if (!_flowerButton) {
        _flowerButton = [[UIButton alloc] init];
        [_flowerButton addTarget:self action:@selector(touchFlowerButton) forControlEvents:UIControlEventTouchUpInside];
        [_flowerButton setImage:[UIImage imageNamed:@"homepage_flower"] forState:UIControlStateNormal];
        [_flowerButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 20, 0.0)];
    }
    return _flowerButton;
}

- (UILabel *)flowerLabel {
    if (!_flowerLabel) {
        _flowerLabel = [[UILabel alloc] init];
        _flowerLabel.text = @"花艺甜品";
        _flowerLabel.textColor = kTextColor;
        _flowerLabel.font = [UIFont systemFontOfSize:14];
        [_flowerLabel sizeToFit];
    }
    return _flowerLabel;
}


- (UIButton *)hotelButton {
    if (!_hotelButton) {
        _hotelButton = [[UIButton alloc] init];
        [_hotelButton addTarget:self action:@selector(touchHotelButton) forControlEvents:UIControlEventTouchUpInside];
        [_hotelButton setImage:[UIImage imageNamed:@"homepage_hotel"] forState:UIControlStateNormal];
        [_hotelButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 20, 0.0)];
    }
    return _hotelButton;
}

- (UILabel *)hotelLabel {
    if (!_hotelLabel) {
        _hotelLabel = [[UILabel alloc] init];
        _hotelLabel.text = @"婚宴酒店";
        _hotelLabel.textColor = kTextColor;
        _hotelLabel.font = [UIFont systemFontOfSize:14];
        [_hotelLabel sizeToFit];
    }
    return _hotelLabel;
}

- (UIButton *)videoButton {
    if (!_videoButton) {
        _videoButton = [[UIButton alloc] init];
        [_videoButton addTarget:self action:@selector(touchVideoButton) forControlEvents:UIControlEventTouchUpInside];
        [_videoButton setImage:[UIImage imageNamed:@"homepage_video"] forState:UIControlStateNormal];
        [_videoButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 20, 0.0)];
    }
    return _videoButton;
}

- (UILabel *)videoLabel {
    if (!_videoLabel) {
        _videoLabel = [[UILabel alloc] init];
        _videoLabel.text = @"视频广告";
        _videoLabel.textColor = kTextColor;
        _videoLabel.font = [UIFont systemFontOfSize:14];
        [_videoLabel sizeToFit];
    }
    return _videoLabel;
}


- (UIButton *)clothButton {
    if (!_clothButton) {
        _clothButton = [[UIButton alloc] init];
        [_clothButton addTarget:self action:@selector(touchClothButton) forControlEvents:UIControlEventTouchUpInside];
        [_clothButton setImage:[UIImage imageNamed:@"homepage_cloth"] forState:UIControlStateNormal];
        [_clothButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 20, 0.0)];
    }
    return _clothButton;
}

- (UILabel *)clothLabel {
    if (!_clothLabel) {
        _clothLabel = [[UILabel alloc] init];
        _clothLabel.text = @"婚纱礼服";
        _clothLabel.textColor = kTextColor;
        _clothLabel.font = [UIFont systemFontOfSize:14];
        [_clothLabel sizeToFit];
    }
    return _clothLabel;
}

- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [[UIButton alloc] init];
        [_moreButton addTarget:self action:@selector(touchMoreButton) forControlEvents:UIControlEventTouchUpInside];
        
        [_moreButton setTitle:@"司仪" forState:UIControlStateNormal];
        [_moreButton setTitleEdgeInsets:UIEdgeInsetsMake(45, -45, 0.0, 0.0)];
        [_moreButton setTitleColor:kTextColor forState:UIControlStateNormal];
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_moreButton setImage:[UIImage imageNamed:@"homepage_more"] forState:UIControlStateNormal];
        [_moreButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 20, 0.0)];
    }
    return _moreButton;
}


@end
