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
    [self.contentView addSubview:self.subIcon];
    [self.contentView addSubview:self.subTitleLabel];
    [self.contentView addSubview:self.subAddress];
    [self.contentView addSubview:self.giftLabel1];
    [self.contentView addSubview:self.giftLabel2];
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
    
    [_subIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(@(40));
        make.width.equalTo(@(40));
    }];
    
    [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_subIcon.mas_top);
        make.left.equalTo(_subIcon.mas_right);
    }];
    
    [_subAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(_subTitleLabel);
    }];
    
    [_giftLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_titleLabel1.mas_left).with.offset(-5);
        make.centerY.equalTo(_titleLabel1);
    }];
    
    [_giftLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_titleLabel2.mas_left).with.offset(-5);
        make.centerY.equalTo(_titleLabel2);
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

- (UIImageView *)subIcon {
    if (!_subIcon) {
        _subIcon = [[UIImageView alloc] init];
    }
    return _subIcon;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.font = [UIFont systemFontOfSize:12];
        _subTitleLabel.textColor = [UIColor colorR:73 G:73 B:73 alpha:1];
    }
    return _subTitleLabel;
}

- (UILabel *)subAddress {
    if (!_subAddress) {
        _subAddress = [[UILabel alloc] init];
        _subAddress.font = [UIFont systemFontOfSize:12];
        _subAddress.textColor = [UIColor colorR:73 G:73 B:73 alpha:1];
    }
    return _subAddress;
}

- (UILabel *)giftLabel1 {
    if (!_giftLabel1) {
        _giftLabel1 = [[UILabel alloc] init];
        _giftLabel1.text = @"优惠礼";
        _giftLabel1.font = [UIFont systemFontOfSize:12];
        _giftLabel1.textColor = [UIColor colorR:246 G:84 B:133 alpha:1];
        _giftLabel1.layer.borderWidth = 1;
        _giftLabel1.layer.borderColor = [[UIColor colorR:246 G:84 B:133 alpha:1] CGColor];
        _giftLabel1.layer.cornerRadius = 5;
        [_giftLabel1 sizeToFit];
        _giftLabel1.hidden = YES;
    }
    return _giftLabel1;
}

- (UILabel *)giftLabel2 {
    if (!_giftLabel2) {
        _giftLabel2 = [[UILabel alloc] init];
        _giftLabel2.text = @"订单礼";
        _giftLabel2.font = [UIFont systemFontOfSize:12];
        _giftLabel2.textColor = [UIColor colorR:246 G:84 B:133 alpha:1];
        _giftLabel2.layer.borderWidth = 1;
        _giftLabel2.layer.borderColor = [[UIColor colorR:246 G:84 B:133 alpha:1] CGColor];
        _giftLabel2.layer.cornerRadius = 5;
        [_giftLabel2 sizeToFit];
        _giftLabel2.hidden = YES;
    }
    return _giftLabel2;
}


@end
