//
//  ShoppingBottomView.m
//  Photo
//
//  Created by malin  on 2017/7/25.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "ShoppingBottomView.h"
#import "Masonry.h"

@implementation ShoppingBottomView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
        [self setImmutableConstraints];
    }
    return self;

}

- (void)initView {
    [self addSubview:self.selectedView];
    [self addSubview:self.selectAll];
    [self addSubview:self.total];
    [self addSubview:self.price];
    [self addSubview:self.buyButton];
}

- (void)setImmutableConstraints {
    [_selectedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.width.equalTo(@(10));
        make.height.equalTo(@(10));
    }];
    
    [_selectAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(_selectedView.mas_right).with.offset(10);
    }];
    
    [_total mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(_total.mas_right).with.offset(10);
    }];
    
    [_buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.mas_right);
        make.width.equalTo(@(100));
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

- (UILabel *)selectAll {
    if (!_selectAll) {
        _selectAll = [[UILabel alloc] init];
        _selectAll.text = @"全选";
        [_selectAll sizeToFit];
    }
    return _selectAll;
}

- (UILabel *)total {
    if (!_total) {
        _total = [[UILabel alloc] init];
        _total.text = @"合计";
        [_total sizeToFit];
    }
    return _total;
}

- (UILabel *)price {
    if (!_price) {
        _price = [[UILabel alloc] init];
        _price.text = @"¥0.0";
        [_price sizeToFit];
    }
    return _price;
}

- (UIButton *)buyButton {
    if (!_buyButton) {
        _buyButton = [[UIButton alloc] init];
        _buyButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:1/255.0 alpha:1.0];
    }
    return _buyButton;
}

@end
