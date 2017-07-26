//
//  PersonalHeaderView.m
//  Photo
//
//  Created by malin  on 2017/7/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "PersonalHeaderView.h"
#import "Masonry.h"

@implementation PersonalHeaderView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
        [self setImmutableConstraints];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.backImageView];
    [self addSubview:self.avatarView];
    [self addSubview:self.userNameLabel];
    [self addSubview:self.phoneNunberLabel];
}

- (void)setImmutableConstraints {
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
    
    [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).with.offset(15);
        make.width.equalTo(@(54));
        make.height.equalTo(@(54));
    }];
    
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [_phoneNunberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userNameLabel.mas_bottom).with.offset(20);
        make.left.equalTo(_userNameLabel.mas_left);
    }];
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
        _avatarView.backgroundColor = [UIColor redColor];
        _avatarView.layer.masksToBounds = YES;
        _avatarView.layer.cornerRadius = 54/2;
    }
    return _avatarView;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.text = @"member_890315";
        _userNameLabel.textColor = [UIColor colorWithRed:248/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        [_userNameLabel sizeToFit];
    }
    return _userNameLabel;
}

- (UILabel *)phoneNunberLabel {
    if (!_phoneNunberLabel) {
        _phoneNunberLabel = [[UILabel alloc] init];
        _phoneNunberLabel.text = @"18275610941";
        _phoneNunberLabel.textColor = [UIColor colorWithRed:221/255.0 green:226/255.0 blue:231/255.0 alpha:1.0];
        [_phoneNunberLabel sizeToFit];
    }
    return _phoneNunberLabel;
}

@end
