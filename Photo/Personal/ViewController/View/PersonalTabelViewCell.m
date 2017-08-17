//
//  PersonalTabelViewCell.m
//  Photo
//
//  Created by malin  on 2017/7/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "PersonalTabelViewCell.h"
#import "Masonry.h"

@implementation PersonalTabelViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
        [self setImmutableConstraints];
    }
    return self;
}

- (void)initView {
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.arrow];
    [self.contentView addSubview:self.icon1];
    [self.contentView addSubview:self.icon2];
    [self.contentView addSubview:self.titleLabel1];
    [self.contentView addSubview:self.titleLabel2];

}

- (void)setImmutableConstraints {
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(@(20));
        make.width.equalTo(@(20));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).with.offset(20);
        make.centerY.equalTo(self.contentView);
    }];
    
    [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-15);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@(15));
        make.height.equalTo(@(15));
    }];
    
    [_icon1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.centerY.equalTo(self.contentView).with.offset(-10);
        make.height.equalTo(@(20));
        make.width.equalTo(@(20));
    }];
    
    [_icon2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.centerY.equalTo(self.contentView).with.offset(10);
        make.height.equalTo(@(20));
        make.width.equalTo(@(20));
    }];
    
    [_titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon1.mas_right).with.offset(20);
        make.top.equalTo(_icon1);
    }];
    
    [_titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon2.mas_right).with.offset(20);
        make.top.equalTo(_icon2);
    }];
}

#pragma mark --- getters and setters ---
- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
    }
    return _icon;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor colorR:73 G:73 B:73 alpha:1];
    }
    return _titleLabel;
}

- (UIImageView *)arrow {
    if (!_arrow) {
        _arrow = [[UIImageView alloc] init];
        _arrow.image = [UIImage imageNamed:@"personal_arrow"];
    }
    return _arrow;
}

- (UIImageView *)icon1 {
    if (!_icon1) {
        _icon1 = [[UIImageView alloc] init];
    }
    return _icon1;
}

- (UIImageView *)icon2 {
    if (!_icon2) {
        _icon2 = [[UIImageView alloc] init];
    }
    return _icon2;
}

- (UILabel *)titleLabel1 {
    if (!_titleLabel1) {
        _titleLabel1 = [[UILabel alloc] init];
        _titleLabel1.font = [UIFont systemFontOfSize:12];
        _titleLabel1.textColor = [UIColor colorR:73 G:73 B:73 alpha:1];
    }
    return _titleLabel1;
}

- (UILabel *)titleLabel2 {
    if (!_titleLabel2) {
        _titleLabel2 = [[UILabel alloc] init];
        _titleLabel2.font = [UIFont systemFontOfSize:12];
        _titleLabel2.textColor = [UIColor colorR:73 G:73 B:73 alpha:1];
    }
    return _titleLabel2;
}

@end
