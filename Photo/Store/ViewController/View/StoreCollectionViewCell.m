//
//  StoreCollectionViewCell.m
//  Photo
//
//  Created by malin  on 2017/8/2.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "StoreCollectionViewCell.h"
#import "Masonry.h"

@implementation StoreCollectionViewCell

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
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.goodsName];
    [self.contentView addSubview:self.goodsPrice];
}

- (void)setImmutableConstraints{
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left);
        make.height.equalTo(@(180));
    }];
    
    [_goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(_imageView.mas_bottom).with.offset(5);
    }];
    
    [_goodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(_goodsName.mas_bottom).with.offset(5);
    }];
}

#pragma mark --- getters and setters ---
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor orangeColor];
    }
    return _imageView;
}

- (UILabel *)goodsName {
    if (!_goodsName) {
        _goodsName = [[UILabel alloc] init];
        _goodsName.backgroundColor = [UIColor blueColor];
        [_goodsName sizeToFit];
    }
    return _goodsName;
}

- (UILabel *)goodsPrice {
    if (!_goodsPrice) {
        _goodsPrice = [[UILabel alloc] init];
        _goodsPrice.backgroundColor = [UIColor greenFont];
        [_goodsPrice sizeToFit];
    }
    return _goodsPrice;
}

@end
