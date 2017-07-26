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
#define kButtonDistance     ([[UIScreen mainScreen] bounds].size.width - kButtonWidth*5+20)/3

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
    [self addSubview:self.carButton];
    [self addSubview:self.flowerButton];
    [self addSubview:self.hotelButton];
    [self addSubview:self.videoButton];
    [self addSubview:self.clothButton];
    [self addSubview:self.moreButton];
}

- (void)setImmutableConstraints {
    [_cameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.top.equalTo(self.mas_top).with.offset(10);
        make.width.equalTo(@(kButtonWidth));
        make.height.equalTo(@(kButtonWidth));
    }];
    
    [_weddingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_cameraButton.mas_right).with.offset(kButtonDistance);
        make.top.equalTo(_cameraButton);
        make.width.equalTo(@(kButtonWidth));
        make.height.equalTo(@(kButtonWidth));
    }];
    
    [_carButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_flowerButton.mas_left).with.offset(-kButtonDistance);
        make.top.equalTo(_cameraButton);
        make.width.equalTo(@(kButtonWidth));
        make.height.equalTo(@(kButtonWidth));
    }];
    
    [_flowerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.top.equalTo(_cameraButton);
        make.width.equalTo(@(kButtonWidth));
        make.height.equalTo(@(kButtonWidth));
    }];
    
    [_hotelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cameraButton.mas_bottom).with.offset(20);
        make.left.equalTo(_cameraButton);
        make.width.equalTo(@(kButtonWidth));
        make.height.equalTo(@(kButtonWidth));
    }];
    
    [_videoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_hotelButton);
        make.left.equalTo(_weddingButton);
        make.width.equalTo(@(kButtonWidth));
        make.height.equalTo(@(kButtonWidth));
    }];
    
    [_clothButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_hotelButton);
        make.right.equalTo(_carButton);
        make.width.equalTo(@(kButtonWidth));
        make.height.equalTo(@(kButtonWidth));
    }];
    
    [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_hotelButton);
        make.right.equalTo(_flowerButton);
        make.width.equalTo(@(kButtonWidth));
        make.height.equalTo(@(kButtonWidth));
    }];
}

#pragma mark --- button method ---
- (void)touchCameraButton {
    
}

- (void)touchWediingButton {
    
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
    
}

- (void)touchMoreButton {
    
}

#pragma mark --- getters and setters ---
- (UIButton *)cameraButton {
    if (!_cameraButton) {
        _cameraButton = [[UIButton alloc] init];
        [_cameraButton addTarget:self action:@selector(touchCameraButton) forControlEvents:UIControlEventTouchUpInside];
        [_cameraButton setImage:[UIImage imageNamed:@"homepage_camera"] forState:UIControlStateNormal];
        [_cameraButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 20, 0)];
        [_cameraButton setTitle:@"摄影" forState:UIControlStateNormal];
        [_cameraButton setTitleEdgeInsets:UIEdgeInsetsMake(30, 0, 0, 0)];
        [_cameraButton setTintColor:[UIColor redColor]];
        _cameraButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _cameraButton;
}

- (UIButton *)weddingButton {
    if (!_weddingButton) {
        _weddingButton = [[UIButton alloc] init];
        [_weddingButton addTarget:self action:@selector(touchWediingButton) forControlEvents:UIControlEventTouchUpInside];
        [_weddingButton setImage:[UIImage imageNamed:@"homepage_wedding"] forState:UIControlStateNormal];
    }
    return _weddingButton;
}


- (UIButton *)carButton {
    if (!_carButton) {
        _carButton = [[UIButton alloc] init];
        [_carButton addTarget:self action:@selector(touchCarButton) forControlEvents:UIControlEventTouchUpInside];
        [_carButton setImage:[UIImage imageNamed:@"homepage_car"] forState:UIControlStateNormal];
    }
    return _carButton;
}


- (UIButton *)flowerButton {
    if (!_flowerButton) {
        _flowerButton = [[UIButton alloc] init];
        [_flowerButton addTarget:self action:@selector(touchFlowerButton) forControlEvents:UIControlEventTouchUpInside];
        [_flowerButton setImage:[UIImage imageNamed:@"homepage_flower"] forState:UIControlStateNormal];
    }
    return _flowerButton;
}


- (UIButton *)hotelButton {
    if (!_hotelButton) {
        _hotelButton = [[UIButton alloc] init];
        [_hotelButton addTarget:self action:@selector(touchHotelButton) forControlEvents:UIControlEventTouchUpInside];
        [_hotelButton setImage:[UIImage imageNamed:@"homepage_hotel"] forState:UIControlStateNormal];
    }
    return _hotelButton;
}


- (UIButton *)videoButton {
    if (!_videoButton) {
        _videoButton = [[UIButton alloc] init];
        [_videoButton addTarget:self action:@selector(touchVideoButton) forControlEvents:UIControlEventTouchUpInside];
        [_videoButton setImage:[UIImage imageNamed:@"homepage_video"] forState:UIControlStateNormal];
    }
    return _videoButton;
}


- (UIButton *)clothButton {
    if (!_clothButton) {
        _clothButton = [[UIButton alloc] init];
        [_clothButton addTarget:self action:@selector(touchClothButton) forControlEvents:UIControlEventTouchUpInside];
        [_clothButton setImage:[UIImage imageNamed:@"homepage_cloth"] forState:UIControlStateNormal];
    }
    return _clothButton;
}


- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [[UIButton alloc] init];
        [_moreButton addTarget:self action:@selector(touchMoreButton) forControlEvents:UIControlEventTouchUpInside];
        [_moreButton setImage:[UIImage imageNamed:@"homepage_more"] forState:UIControlStateNormal];
    }
    return _moreButton;
}


@end
