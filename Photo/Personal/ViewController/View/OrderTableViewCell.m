//
//  OrderTableViewCell.m
//  Photo
//
//  Created by malin  on 2017/7/31.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "OrderTableViewCell.h"
#import "Masonry.h"

@implementation OrderTableViewCell

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
    [self.contentView addSubview:self.goodsParameter];
    [self.contentView addSubview:self.goodsNumber];
    [self.contentView addSubview:self.time];
    [self.contentView addSubview:self.goodsCount];
    [self.contentView addSubview:self.goodsPrice];
    [self.contentView addSubview:self.goodsState];
}

- (void)setImmutableConstraints {
    [_goodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).with.offset(5);
        make.width.equalTo(@(60));
        make.height.equalTo(@(60));
    }];
    
    [_goodsNamme mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_goodsImage.mas_right).with.offset(10);
        make.bottom.equalTo(_goodsImage.mas_top).with.offset(5);
    }];
    
    [_goodsParameter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_goodsNamme);
        make.top.equalTo(_goodsImage.mas_top).with.offset(5);
    }];
    
    [_goodsNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_goodsNamme);
        make.top.equalTo(_goodsParameter.mas_bottom).with.offset(5);
    }];
    
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_goodsNamme);
        make.top.equalTo(_goodsNumber.mas_bottom).with.offset(5);
    }];
    
    [_goodsCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_goodsNamme);
        make.top.equalTo(_time.mas_bottom).with.offset(5);
    }];
    
    [_goodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_goodsCount.mas_right).with.offset(10);
        make.top.equalTo(_goodsCount);
    }];
    
    [_goodsState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodsNamme);
        make.right.equalTo(self.contentView.mas_right).with.offset(-40);
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

- (UILabel *)goodsParameter {
    if (!_goodsParameter) {
        _goodsParameter = [[UILabel alloc] init];
        _goodsParameter.textColor = [UIColor colorWithRed:148/255.0 green:149/255.0 blue:151/255.0 alpha:1.0];
        [_goodsParameter sizeToFit];
    }
    return _goodsParameter;
}

- (UILabel *)goodsNumber {
    if (!_goodsNumber) {
        _goodsNumber = [[UILabel alloc] init];
        _goodsNumber.textColor = [UIColor colorWithRed:148/255.0 green:149/255.0 blue:151/255.0 alpha:1.0];
        [_goodsNumber sizeToFit];

    }
    return _goodsNumber;
}


- (UILabel *)time {
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.textColor = [UIColor colorWithRed:148/255.0 green:149/255.0 blue:151/255.0 alpha:1.0];
        [_time sizeToFit];
    }
    return _time;
}

- (UILabel *)goodsCount {
    if (!_goodsCount) {
        _goodsCount = [[UILabel alloc] init];
        _goodsCount.textColor = [UIColor colorWithRed:148/255.0 green:149/255.0 blue:151/255.0 alpha:1.0];
        [_goodsCount sizeToFit];
    }
    return _goodsCount;
}

- (UILabel *)goodsPrice {
    if (!_goodsPrice) {
        _goodsPrice = [[UILabel alloc] init];
        _goodsPrice.textColor = [UIColor colorWithRed:148/255.0 green:149/255.0 blue:151/255.0 alpha:1.0];
        [_goodsPrice sizeToFit];
    }
    return _goodsPrice;
}

- (UILabel *)goodsState {
    if (!_goodsState) {
        _goodsState = [[UILabel alloc] init];
        _goodsState.textColor = [UIColor colorWithRed:148/255.0 green:149/255.0 blue:151/255.0 alpha:1.0];
        [_goodsState sizeToFit];
    }
    return _goodsState;
}


@end
