//
//  ShoppingTableViewCell.m
//  Photo
//
//  Created by malin  on 2017/7/25.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "ShoppingTableViewCell.h"
#import "Masonry.h"

@implementation ShoppingTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
        [self setImmutableConstraints];
    }
    return self;
}

- (void)initView {
    [self.contentView addSubview:self.selectedView];
    [self.contentView addSubview:self.goodsImage];
    [self.contentView addSubview:self.goodsName];
    [self.contentView addSubview:self.goodsParameter];
    [self.contentView addSubview:self.goodsPrice];
    [self.contentView addSubview:self.goodsCount];
    [self.contentView addSubview:self.deleteButton];
}

- (void)setImmutableConstraints {
    [_selectedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.mas_left).with.offset(5);
        make.width.equalTo(@(20));
        make.height.equalTo(@(20));
    }];
    
    [_goodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(_selectedView.mas_right).with.offset(10);
        make.height.equalTo(@(80));
        make.width.equalTo(@(80));
    }];
    
    [_goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodsImage.mas_top).with.offset(-5);
        make.left.equalTo(_goodsImage.mas_right).with.offset(10);
    }];
    
    [_goodsParameter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodsName.mas_bottom).with.offset(5);
        make.left.equalTo(_goodsName);
    }];
    
    [_goodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodsParameter.mas_bottom).with.offset(5);
        make.left.equalTo(_goodsName);
    }];
    
    [_goodsCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodsPrice.mas_bottom).with.offset(5);
        make.left.equalTo(_goodsName);
    }];
    
    [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodsPrice);
        make.right.equalTo(self.contentView.mas_right).with.offset(-15);
        make.height.equalTo(@(30));
        make.width.equalTo(@(80));
    }];
}

#pragma mark --- getters and setters ---
- (UIImageView *)selectedView {
    if (!_selectedView) {
        _selectedView = [[UIImageView alloc] init];
        _selectedView.backgroundColor = [UIColor redColor];
    }
    return _selectedView;
}

- (UIImageView *)goodsImage {
    if (!_goodsImage) {
        _goodsImage = [[UIImageView alloc] init];
        _goodsImage.backgroundColor = [UIColor blueColor];
    }
    return _goodsImage;
}

- (UILabel *)goodsName {
    if (!_goodsName) {
        _goodsName = [[UILabel alloc] init];
        _goodsName.text = @"商品名称";
        [_goodsName sizeToFit];
    }
    return _goodsName;
}

- (UILabel *)goodsParameter {
    if (!_goodsParameter) {
        _goodsParameter = [[UILabel alloc] init];
        _goodsParameter.text = @"产品参数";
        [_goodsParameter sizeToFit];
    }
    return _goodsParameter;
}

- (UILabel *)goodsPrice {
    if (!_goodsPrice) {
        _goodsPrice = [[UILabel alloc] init];
        _goodsPrice.text = @"商品价格";
        [_goodsPrice sizeToFit];
    }
    return _goodsPrice;
}

- (UILabel *)goodsCount {
    if (!_goodsCount) {
        _goodsCount = [[UILabel alloc] init];
        _goodsCount.text = @"商品数量";
        [_goodsCount sizeToFit];
    }
    return _goodsCount;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc] init];
        _deleteButton.backgroundColor = [UIColor greenColor];
    }
    return _deleteButton;
}

@end
