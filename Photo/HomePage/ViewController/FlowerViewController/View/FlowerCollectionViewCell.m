//
//  FlowerCollectionViewCell.m
//  Photo
//
//  Created by malin  on 2017/8/29.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "FlowerCollectionViewCell.h"

@implementation FlowerCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
        [self setImmutableConstraints];
    }
    return self;
}

- (void)initView
{
    [self.contentView addSubview:self.flowerView];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.descLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.oldPriceLabel];
}

- (void)setImmutableConstraints{
    [_flowerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-60);
    }];
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_flowerView);
        make.centerX.equalTo(_flowerView);
        make.bottom.equalTo(_flowerView.mas_bottom);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_flowerView.mas_left);
        make.top.equalTo(_flowerView.mas_bottom).with.offset(5);
    }];
    
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).with.offset(5);
        make.left.equalTo(_nameLabel.mas_left);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_left);
        make.top.equalTo(_descLabel.mas_bottom).with.offset(5);
    }];
    
    [_oldPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_priceLabel.mas_right).with.offset(5);
        make.top.equalTo(_priceLabel);
    }];
    
}

#pragma mark --- getters and setters ---
- (UIImageView *)flowerView {
    if (!_flowerView) {
        _flowerView = [[UIImageView alloc] init];
    }
    return _flowerView;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = [UIFont systemFontOfSize:14];
        _addressLabel.backgroundColor = [UIColor blackColor];
        _addressLabel.alpha = 0.5;
        _addressLabel.textColor = [UIColor whiteColor];
        _addressLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _addressLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor colorR:254 G:0 B:112 alpha:1];
    }
    return _nameLabel;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.font = [UIFont systemFontOfSize:14];
        _descLabel.textColor = [UIColor colorR:148 G:148 B:148 alpha:1];
    }
    return _descLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont systemFontOfSize:14];
        _priceLabel.textColor = [UIColor colorR:254 G:0 B:112 alpha:1];
    }
    return _priceLabel;
}

- (UILabel *)oldPriceLabel {
    if (!_oldPriceLabel) {
        _oldPriceLabel = [[UILabel alloc] init];
        _oldPriceLabel.font = [UIFont systemFontOfSize:14];
        _oldPriceLabel.textColor = [UIColor colorR:184 G:184 B:184 alpha:1];
    }
    return _oldPriceLabel;
}


@end
