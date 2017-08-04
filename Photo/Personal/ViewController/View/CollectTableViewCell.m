//
//  CollectTableViewCell.m
//  Photo
//
//  Created by malin  on 2017/7/25.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "CollectTableViewCell.h"
#import "Masonry.h"

@implementation CollectTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
        [self setImmutableConstraints];
        self.contentView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    }
    return self;
}

- (void)initView {
    [self.contentView addSubview:self.goodsImage];
    [self.contentView addSubview:self.goodsNamme];
    [self.contentView addSubview:self.goodsSales];
    [self.contentView addSubview:self.goodsPrice];
    [self.contentView addSubview:self.time];
    [self.contentView addSubview:self.lookUpButton];
    [self.contentView addSubview:self.buyButton];
    [self.contentView addSubview:self.cancelColletButton];
}

- (void)setImmutableConstraints {
    [_goodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).with.offset(5);
        make.width.equalTo(@(80));
        make.height.equalTo(@(80));
    }];
    
    [_goodsNamme mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_goodsImage.mas_right).with.offset(20);
        make.bottom.equalTo(_goodsImage.mas_top).with.offset(-10);
    }];
    
    [_goodsSales mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_goodsNamme);
        make.top.equalTo(_goodsImage.mas_top).with.offset(5);
    }];
    
    [_goodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_goodsNamme);
        make.top.equalTo(_goodsSales.mas_bottom).with.offset(5);
    }];
    
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_goodsNamme);
        make.top.equalTo(_goodsPrice.mas_bottom).with.offset(5);
    }];
    
    [_lookUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_goodsNamme);
        make.top.equalTo(_time.mas_bottom).with.offset(5);
        make.width.equalTo(@(60));
        make.height.equalTo(@(30));
    }];
    
    [_buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lookUpButton.mas_right).with.offset(10);
        make.top.equalTo(_lookUpButton);
        make.width.equalTo(@(60));
        make.height.equalTo(@(30));
    }];
    
    [_cancelColletButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodsNamme);
        make.right.equalTo(self.contentView.mas_right).with.offset(-40);
        make.width.equalTo(@(90));
        make.height.equalTo(@(30));
    }];
}

#pragma mark --- getters and setters ---
- (UIImageView *)goodsImage {
    if (!_goodsImage) {
        _goodsImage = [[UIImageView alloc] init];
        _goodsImage.backgroundColor = [UIColor redColor];
    }
    return _goodsImage;
}

- (UILabel *)goodsNamme {
    if (!_goodsNamme) {
        _goodsNamme = [[UILabel alloc] init];
        _goodsNamme.textColor = [UIColor colorWithRed:51/255.0 green:52/255.0 blue:59/255.0 alpha:1.0];
        [_goodsNamme sizeToFit];
    }
    return _goodsNamme;
}

- (UILabel *)goodsSales {
    if (!_goodsSales) {
        _goodsSales = [[UILabel alloc] init];
        _goodsSales.textColor = [UIColor colorWithRed:148/255.0 green:149/255.0 blue:151/255.0 alpha:1.0];
        [_goodsSales sizeToFit];
    }
    return _goodsSales;
}

- (UILabel *)goodsPrice {
    if (!_goodsPrice) {
        _goodsPrice = [[UILabel alloc] init];
        _goodsPrice.textColor = [UIColor colorWithRed:148/255.0 green:149/255.0 blue:151/255.0 alpha:1.0];
        [_goodsPrice sizeToFit];
    }
    return _goodsPrice;
}

- (UILabel *)time {
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.text = [NSString stringWithFormat:@"收藏时间 %d",2017-07-19];
        _time.textColor = [UIColor colorWithRed:148/255.0 green:149/255.0 blue:151/255.0 alpha:1.0];
        [_time sizeToFit];
    }
    return _time;
}

- (UIButton *)lookUpButton {
    if (!_lookUpButton) {
        _lookUpButton = [[UIButton alloc] init];
        [_lookUpButton setTitle:@"查看" forState:UIControlStateNormal];
        [_lookUpButton setTitleColor:[UIColor colorR:89 G:93 B:94 alpha:1] forState:UIControlStateNormal];
//        _lookUpButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _lookUpButton.backgroundColor = [UIColor colorR:240 G:240 B:240 alpha:1];
        _lookUpButton.layer.cornerRadius = 8;
    }
    return _lookUpButton;
}

- (UIButton *)buyButton {
    if (!_buyButton) {
        _buyButton = [[UIButton alloc] init];
        [_buyButton setTitle:@"购买" forState:UIControlStateNormal];
//        _buyButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_buyButton setTitleColor:[UIColor colorR:247 G:134 B:35 alpha:1] forState:UIControlStateNormal];
        _buyButton.backgroundColor = [UIColor colorR:240 G:240 B:240 alpha:1];
        _buyButton.layer.borderWidth = 0.5;
        _buyButton.layer.borderColor = [[UIColor colorR:255 G:226 B:197 alpha:1] CGColor];
        _buyButton.layer.cornerRadius = 8;
    }
    return _buyButton;
}

- (UIButton *)cancelColletButton {
    if (!_cancelColletButton) {
        _cancelColletButton = [[UIButton alloc] init];
        [_cancelColletButton setTitle:@"取消收藏" forState:UIControlStateNormal];
        _cancelColletButton.backgroundColor = [UIColor colorR:240 G:240 B:240 alpha:1];
        _cancelColletButton.layer.cornerRadius = 8;
        [_cancelColletButton setTitleColor:[UIColor colorR:84 G:84 B:86 alpha:1] forState:UIControlStateNormal];

    }
    return _cancelColletButton;
}

@end
