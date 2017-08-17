//
//  PersonalHeaderView.m
//  Photo
//
//  Created by malin  on 2017/7/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "PersonalHeaderView.h"
#import "Masonry.h"
#import "LoginManager.h"
#import "SDWebImageCache.h"

@implementation PersonalHeaderView

-(id)initWithFrame:(CGRect)frame withIsLoginOut:(BOOL)loginOut {
    self = [super initWithFrame:frame];
    if (self) {
        self.loginOut = loginOut;
        self.info = GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo;
        [self initView];
        [self setImmutableConstraints];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.backImageView];
    if (self.loginOut) {
        [self addSubview:self.title];
        [self addSubview:self.subTitle];
        [self addSubview:self.loginButton];
    } else {
        [self addSubview:self.avatarView];
        [self addSubview:self.userNameLabel];
        [self addSubview:self.phoneNunberLabel];
        [self addSubview:self.arrowView];
    }
}

- (void)setImmutableConstraints {
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];

    if (self.loginOut) {
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).with.offset(-10);
            make.centerX.equalTo(self);
        }];
        
        [_subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_title.mas_bottom).with.offset(10);
            make.centerX.equalTo(self);
        }];
        
        [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_subTitle.mas_bottom).with.offset(6);
            make.centerX.equalTo(self);
            make.width.equalTo(@(120));
            make.height.equalTo(@(30));
        }];
    } else {
        [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.mas_left).with.offset(18);
            make.width.equalTo(@(68));
            make.height.equalTo(@(68));
        }];
        
        [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_avatarView.mas_right).with.offset(14);
            make.centerY.equalTo(self).with.offset(-15);
        }];
        
        [_phoneNunberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_userNameLabel.mas_bottom).with.offset(6);
            make.left.equalTo(_userNameLabel.mas_left);
        }];
        
        [_arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.mas_right).with.offset(-20);
            make.height.equalTo(@(15));
            make.width.equalTo(@(15));
        }];
    }
}

#pragma mark --- getters and setters ---
- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = [UIImage imageNamed:@"personal_header_image.jpg"];
    }
    return _backImageView;
}

- (UIImageView *)avatarView {
    if (!_avatarView) {
        _avatarView = [[AvatarView alloc] init];
        [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,self.info.memberPic] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            _avatarView.image = image;
        }];
        _avatarView.layer.masksToBounds = YES;
        _avatarView.layer.cornerRadius = 68/2;
    }
    return _avatarView;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.text = self.info.memberNickName;
        _userNameLabel.textColor = [UIColor colorWithRed:248/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        [_userNameLabel sizeToFit];
    }
    return _userNameLabel;
}

- (UILabel *)phoneNunberLabel {
    if (!_phoneNunberLabel) {
        _phoneNunberLabel = [[UILabel alloc] init];
        _phoneNunberLabel.text = self.info.memberPhone;
        _phoneNunberLabel.textColor = [UIColor colorWithRed:221/255.0 green:226/255.0 blue:231/255.0 alpha:1.0];
        [_phoneNunberLabel sizeToFit];
    }
    return _phoneNunberLabel;
}

- (UIImageView *)arrowView {
    if (!_arrowView) {
        _arrowView = [[UIImageView alloc] init];
        _arrowView.image = [UIImage imageNamed:@"personal_forward"];
    }
    return _arrowView;
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"登录婚纱摄影";
        _title.font = [UIFont systemFontOfSize:14];
        [_title sizeToFit];
    }
    return _title;
}

- (UILabel *)subTitle {
    if (!_subTitle) {
        _subTitle = [[UILabel alloc] init];
        _subTitle.text = @"足不出户即可选择高端摄影~";
        _subTitle.font = [UIFont systemFontOfSize:14];
        [_subTitle sizeToFit];
    }
    return _subTitle;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] init];
        [_loginButton setTitle:@"立即登录" forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _loginButton.layer.borderWidth = 1;
        _loginButton.layer.borderColor = [[UIColor whiteColor] CGColor];
        _loginButton.layer.cornerRadius = 5;
    }
    return _loginButton;
}

- (void)loginButtonClick {
    if ([self.delegate respondsToSelector:@selector(loginButtonClick)]) {
        [self.delegate loginButtonClick];
    }
}

@end
