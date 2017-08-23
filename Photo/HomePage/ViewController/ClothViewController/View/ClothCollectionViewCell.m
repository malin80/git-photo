
//
//  ClothCollectionViewCell.m
//  Photo
//
//  Created by malin  on 2017/8/23.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "ClothCollectionViewCell.h"

@implementation ClothCollectionViewCell


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
    [self.contentView addSubview:self.clothName];
    [self.contentView addSubview:self.clothPrice];
    [self.contentView addSubview:self.clothOldPrice];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.icon1];
    [self.contentView addSubview:self.icon2];
}

- (void)setImmutableConstraints{
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-40);
        make.top.equalTo(self.contentView.mas_top);
    }];
    
    [_clothName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView.mas_bottom);
        make.left.equalTo(_imageView.mas_left);
        make.width.equalTo(_imageView);
    }];
    
    [_clothPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageView.mas_left);
        make.top.equalTo(_clothName.mas_bottom);
    }];
    
    [_clothOldPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_clothPrice);
        make.left.equalTo(_clothPrice.mas_right).with.offset(5);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_clothOldPrice);
        make.width.equalTo(_clothOldPrice);
        make.height.equalTo(@(1));
        make.left.equalTo(_clothOldPrice.mas_left);
    }];
    
    [_icon1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_clothPrice);
        make.left.equalTo(_clothOldPrice.mas_right).with.offset(5);
    }];
    
    [_icon2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_icon1);
        make.left.equalTo(_icon1.mas_right).with.offset(5);
    }];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UILabel *)clothName {
    if (!_clothName) {
        _clothName = [[UILabel alloc] init];
        _clothName.textColor = [UIColor colorR:76 G:77 B:79 alpha:1];
        _clothName.font = [UIFont systemFontOfSize:14];
        [_clothName sizeToFit];
    }
    return _clothName;
}

- (UILabel *)clothPrice {
    if (!_clothPrice) {
        _clothPrice = [[UILabel alloc] init];
        _clothPrice.textColor = [UIColor colorR:255 G:122 B:1 alpha:1];
        _clothPrice.font = [UIFont systemFontOfSize:14];
        [_clothPrice sizeToFit];
    }
    return _clothPrice;
}

- (UILabel *)clothOldPrice {
    if (!_clothOldPrice) {
        _clothOldPrice = [[UILabel alloc] init];
        _clothOldPrice.textColor = [UIColor colorR:176 G:176 B:176 alpha:1];
        _clothOldPrice.font = [UIFont systemFontOfSize:14];
        [_clothOldPrice sizeToFit];
    }
    return _clothOldPrice;
}

- (UILabel *)line {
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = [UIColor colorR:176 G:176 B:176 alpha:1];
    }
    return _line;
}

- (UILabel *)icon1 {
    if (!_icon1) {
        _icon1 = [[UILabel alloc] init];
        _icon1.text = @"惠";
        _icon1.font = [UIFont systemFontOfSize:14];
        _icon1.backgroundColor = [UIColor colorR:197 G:221 B:100 alpha:1];
    }
    return _icon1;
}

- (UILabel *)icon2 {
    if (!_icon2) {
        _icon2 = [[UILabel alloc] init];
        _icon2.text = @"租";
        _icon2.font = [UIFont systemFontOfSize:14];
        _icon2.backgroundColor = [UIColor colorR:117 G:176 B:235 alpha:1];
        _icon2.hidden = YES;
    }
    return _icon2;
}

@end
