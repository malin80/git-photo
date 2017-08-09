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
    [self.contentView addSubview:self.line];
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
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodsPrice.mas_bottom).with.offset(5);
        make.width.equalTo(_imageView);
        make.height.equalTo(@(0.5));
        make.left.equalTo(_imageView.mas_left);
    }];
}

#pragma mark --- getters and setters ---
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UILabel *)goodsName {
    if (!_goodsName) {
        _goodsName = [[UILabel alloc] init];
        _goodsName.textColor = [UIColor colorR:76 G:77 B:79 alpha:1];
        _goodsName.font = [UIFont systemFontOfSize:14];
        [_goodsName sizeToFit];
    }
    return _goodsName;
}

- (UILabel *)goodsPrice {
    if (!_goodsPrice) {
        _goodsPrice = [[UILabel alloc] init];
        _goodsPrice.textColor = [UIColor colorR:255 G:122 B:1 alpha:1];
        _goodsPrice.font = [UIFont systemFontOfSize:14];
        [_goodsPrice sizeToFit];
    }
    return _goodsPrice;
}

- (UILabel *)line {
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = [UIColor darkGrayColor];
    }
    return _line;
}

@end
