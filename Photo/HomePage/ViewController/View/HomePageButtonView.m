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
        make.height.equalTo(@(kButtonHeitht));
    }];
    
    [_weddingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_cameraButton.mas_right).with.offset(kButtonDistance);
        make.top.equalTo(_cameraButton);
        make.width.equalTo(@(kButtonWidth));
        make.height.equalTo(@(kButtonHeitht));
    }];
    
    [_carButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_flowerButton.mas_left).with.offset(-kButtonDistance);
        make.top.equalTo(_cameraButton);
        make.width.equalTo(@(kButtonWidth));
        make.height.equalTo(@(kButtonHeitht));
    }];
    
    [_flowerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.top.equalTo(_cameraButton);
        make.width.equalTo(@(kButtonWidth));
        make.height.equalTo(@(kButtonHeitht));
    }];
    
    [_hotelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cameraButton.mas_bottom).with.offset(20);
        make.left.equalTo(_cameraButton);
        make.width.equalTo(@(kButtonWidth));
        make.height.equalTo(@(kButtonHeitht));
    }];
    
    [_videoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_hotelButton);
        make.left.equalTo(_weddingButton);
        make.width.equalTo(@(kButtonWidth));
        make.height.equalTo(@(kButtonHeitht));
    }];
    
    [_clothButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_hotelButton);
        make.right.equalTo(_carButton);
        make.width.equalTo(@(kButtonWidth));
        make.height.equalTo(@(kButtonHeitht));
    }];
    
    [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_hotelButton);
        make.right.equalTo(_flowerButton);
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
        
        [_weddingButton setTitle:@"婚庆" forState:UIControlStateNormal];
        [_weddingButton setTitleEdgeInsets:UIEdgeInsetsMake(45, -45, 0.0, 0.0)];
        [_weddingButton setTitleColor:kTextColor forState:UIControlStateNormal];
        _weddingButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_weddingButton setImage:[UIImage imageNamed:@"homepage_wedding"] forState:UIControlStateNormal];
        [_weddingButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 20, 0.0)];
    }
    return _weddingButton;
}


- (UIButton *)carButton {
    if (!_carButton) {
        _carButton = [[UIButton alloc] init];
        [_carButton addTarget:self action:@selector(touchCarButton) forControlEvents:UIControlEventTouchUpInside];
        
        [_carButton setTitle:@"婚车" forState:UIControlStateNormal];
        [_carButton setTitleEdgeInsets:UIEdgeInsetsMake(45, -45, 0.0, 0.0)];
        [_carButton setTitleColor:kTextColor forState:UIControlStateNormal];
        _carButton.titleLabel.font = [UIFont systemFontOfSize:14];
//        _carButton.titleLabel.adjustsFontSizeToFitWidth=YES;
        [_carButton setImage:[UIImage imageNamed:@"homepage_car"] forState:UIControlStateNormal];
        [_carButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 20, 0.0)];
    }
    return _carButton;
}


- (UIButton *)flowerButton {
    if (!_flowerButton) {
        _flowerButton = [[UIButton alloc] init];
        [_flowerButton addTarget:self action:@selector(touchFlowerButton) forControlEvents:UIControlEventTouchUpInside];
        
        [_flowerButton setTitle:@"花艺" forState:UIControlStateNormal];
        [_flowerButton setTitleEdgeInsets:UIEdgeInsetsMake(45, -45, 0.0, 0.0)];
        [_flowerButton setTitleColor:kTextColor forState:UIControlStateNormal];
        _flowerButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_flowerButton setImage:[UIImage imageNamed:@"homepage_flower"] forState:UIControlStateNormal];
        [_flowerButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 20, 0.0)];
    }
    return _flowerButton;
}


- (UIButton *)hotelButton {
    if (!_hotelButton) {
        _hotelButton = [[UIButton alloc] init];
        [_hotelButton addTarget:self action:@selector(touchHotelButton) forControlEvents:UIControlEventTouchUpInside];
        
        [_hotelButton setTitle:@"酒店" forState:UIControlStateNormal];
        [_hotelButton setTitleEdgeInsets:UIEdgeInsetsMake(45, -45, 0.0, 0.0)];
        [_hotelButton setTitleColor:kTextColor forState:UIControlStateNormal];
        _hotelButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_hotelButton setImage:[UIImage imageNamed:@"homepage_hotel"] forState:UIControlStateNormal];
        [_hotelButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 20, 0.0)];
    }
    return _hotelButton;
}


- (UIButton *)videoButton {
    if (!_videoButton) {
        _videoButton = [[UIButton alloc] init];
        [_videoButton addTarget:self action:@selector(touchVideoButton) forControlEvents:UIControlEventTouchUpInside];
        
        [_videoButton setTitle:@"视频" forState:UIControlStateNormal];
        [_videoButton setTitleEdgeInsets:UIEdgeInsetsMake(45, -45, 0.0, 0.0)];
        [_videoButton setTitleColor:kTextColor forState:UIControlStateNormal];
        _videoButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_videoButton setImage:[UIImage imageNamed:@"homepage_video"] forState:UIControlStateNormal];
        [_videoButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 20, 0.0)];
    }
    return _videoButton;
}


- (UIButton *)clothButton {
    if (!_clothButton) {
        _clothButton = [[UIButton alloc] init];
        [_clothButton addTarget:self action:@selector(touchClothButton) forControlEvents:UIControlEventTouchUpInside];
        
        [_clothButton setTitle:@"婚纱" forState:UIControlStateNormal];
        [_clothButton setTitleEdgeInsets:UIEdgeInsetsMake(45, -45, 0.0, 0.0)];
        [_clothButton setTitleColor:kTextColor forState:UIControlStateNormal];
        _clothButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _clothButton.titleLabel.frame = CGRectMake(0, 0, 100, 20);
        
        [_clothButton setImage:[UIImage imageNamed:@"homepage_cloth"] forState:UIControlStateNormal];
        [_clothButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 20, 0.0)];
    }
    return _clothButton;
}


- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [[UIButton alloc] init];
        [_moreButton addTarget:self action:@selector(touchMoreButton) forControlEvents:UIControlEventTouchUpInside];
        
        [_moreButton setTitle:@"更多" forState:UIControlStateNormal];
        [_moreButton setTitleEdgeInsets:UIEdgeInsetsMake(45, -45, 0.0, 0.0)];
        [_moreButton setTitleColor:kTextColor forState:UIControlStateNormal];
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_moreButton setImage:[UIImage imageNamed:@"homepage_more"] forState:UIControlStateNormal];
        [_moreButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 20, 0.0)];
    }
    return _moreButton;
}


@end
