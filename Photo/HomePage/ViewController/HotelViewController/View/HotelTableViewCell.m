//
//  HotelTableViewCell.m
//  Photo
//
//  Created by malin  on 2017/8/25.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "HotelTableViewCell.h"

@implementation HotelTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
        [self setImmutableConstraints];
    }
    return self;
}

- (void)initView
{
    [self addSubview:self.titleView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.contailLabel];
    [self addSubview:self.typeLabel];
    [self addSubview:self.addressLabel];
    [self addSubview:self.goldView];
    [self addSubview:self.giftIcon];

}

- (void)setImmutableConstraints{
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(5);
        make.top.equalTo(self.mas_top).with.offset(5);
        make.bottom.equalTo(self.mas_bottom).with.offset(-5);
        make.width.equalTo(@(70));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleView.mas_top);
        make.left.equalTo(_titleView.mas_right).with.offset(10);
    }];
    
    [_giftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_nameLabel);
        make.left.equalTo(_nameLabel.mas_right).with.offset(10);
        make.height.equalTo(@(15));
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.centerY.equalTo(_titleView);
    }];
    
    [_contailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-5);
        make.centerY.equalTo(_titleView).with.offset(-10);
        make.width.equalTo(@(60));
    }];
    
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_priceLabel);
        make.bottom.equalTo(_titleView.mas_bottom);
    }];
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_typeLabel);
        make.left.equalTo(_typeLabel.mas_right).with.offset(20);
        make.right.equalTo(_contailLabel.mas_left);
    }];
    
    [_goldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleView).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(-5);
        make.height.equalTo(@(20));
        make.width.equalTo(@(40));
    }];
}

#pragma mark --- getters and setters ---
- (UIImageView *)titleView {
    if (!_titleView) {
        _titleView = [[UIImageView alloc] init];
    }
    return _titleView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor colorR:131 G:131 B:131 alpha:1];
    }
    return _nameLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont systemFontOfSize:12];
        _priceLabel.textColor = [UIColor colorR:131 G:131 B:131 alpha:1];
    }
    return _priceLabel;
}

- (UILabel *)contailLabel {
    if (!_contailLabel) {
        _contailLabel = [[UILabel alloc] init];
        _contailLabel.font = [UIFont systemFontOfSize:12];
        _contailLabel.textColor = [UIColor colorR:131 G:131 B:131 alpha:1];
    }
    return _contailLabel;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.font = [UIFont systemFontOfSize:12];
        _typeLabel.textColor = [UIColor colorR:198 G:198 B:198 alpha:1];
    }
    return _typeLabel;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = [UIFont systemFontOfSize:12];
        _addressLabel.textColor = [UIColor colorR:198 G:198 B:198 alpha:1];
    }
    return _addressLabel;
}

- (UIImageView *)goldView {
    if (!_goldView) {
        _goldView = [[UIImageView alloc] init];
        _goldView.image = [UIImage imageNamed:@"jinpai_hotel"];
    }
    return _goldView;
}

- (UILabel *)giftIcon {
    if (!_giftIcon) {
        _giftIcon = [[UILabel alloc] init];
        _giftIcon.text = @"礼";
        _giftIcon.font = [UIFont systemFontOfSize:12];
        _giftIcon.textColor = [UIColor whiteColor];
        _giftIcon.backgroundColor = [UIColor colorR:116 G:187 B:246 alpha:1];
    }
    return _giftIcon;
}



@end
