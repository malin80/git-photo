//
//  CarCollectionViewCell.m
//  Photo
//
//  Created by malin  on 2017/8/28.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "CarCollectionViewCell.h"

@implementation CarCollectionViewCell

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
    [self.contentView addSubview:self.carView];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.phoneLabel];
}

- (void)setImmutableConstraints{
    [_carView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-40);
    }];
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(_carView.mas_bottom).with.offset(5);
    }];
    
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(_addressLabel.mas_bottom).with.offset(5);
    }];
}

#pragma mark --- getters and setters ---
- (UIImageView *)carView {
    if (!_carView) {
        _carView = [[UIImageView alloc] init];
    }
    return _carView;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.textColor = [UIColor colorR:83 G:87 B:85 alpha:1];
        _addressLabel.font = [UIFont systemFontOfSize:14];
    }
    return _addressLabel;
}

- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.textColor = [UIColor colorR:83 G:87 B:85 alpha:1];
        _phoneLabel.font = [UIFont systemFontOfSize:14];
    }
    return _phoneLabel;
}

@end
