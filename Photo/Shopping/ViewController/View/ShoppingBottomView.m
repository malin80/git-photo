//
//  ShoppingBottomView.m
//  Photo
//
//  Created by malin  on 2017/7/25.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "ShoppingBottomView.h"
#import "Masonry.h"
#import "ShoppingManager.h"

@implementation ShoppingBottomView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
        [self setImmutableConstraints];
        
        self.info = GET_SINGLETON_FOR_CLASS(ShoppingManager).shoppingGoodsInfos[0];
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
        make.width.equalTo(@(20));
        make.height.equalTo(@(20));
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
- (UIButton *)selectedView {
    if (!_selectedView) {
        _selectedView = [[UIButton alloc] init];
        [_selectedView setBackgroundImage:[UIImage imageNamed:@"shopping_select"] forState:UIControlStateNormal];
        [_selectedView setBackgroundImage:[UIImage imageNamed:@"shopping_selected"] forState:UIControlStateSelected];
        [_selectedView addTarget:self action:@selector(changeSelectViewIconState) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectedView;
}

- (UILabel *)selectAll {
    if (!_selectAll) {
        _selectAll = [[UILabel alloc] init];
        _selectAll.text = @"全选";
        _selectAll.textColor = [UIColor colorR:65 G:67 B:66 alpha:1];
        _selectAll.font = [UIFont systemFontOfSize:15];
        [_selectAll sizeToFit];
    }
    return _selectAll;
}

- (UILabel *)total {
    if (!_total) {
        _total = [[UILabel alloc] init];
        _total.text = @"合计";
        _total.textColor = [UIColor colorR:65 G:67 B:66 alpha:1];
        _total.font = [UIFont systemFontOfSize:15];
        [_total sizeToFit];
    }
    return _total;
}

- (UILabel *)price {
    if (!_price) {
        _price = [[UILabel alloc] init];
        _price.text = [NSString stringWithFormat:@"¥：%ld",self.info.goodsCartPrice];
        _price.textColor = [UIColor colorWithRed:246/255.0 green:118/255.0 blue:2/255.0 alpha:1.0];
        _price.font = [UIFont systemFontOfSize:15];
        [_price sizeToFit];
    }
    return _price;
}

- (UIButton *)buyButton {
    if (!_buyButton) {
        _buyButton = [[UIButton alloc] init];
        _buyButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:1/255.0 alpha:1.0];
        NSString *str = [NSString stringWithFormat:@"结算（0）"];
        [_buyButton setTitle:str forState:UIControlStateNormal];
        [_buyButton addTarget:self action:@selector(buyButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyButton;
}

#pragma mark --- gestuer ---
//勾选按钮状态的改变
- (void)changeSelectViewIconWithSelected:(BOOL)selected
{
    //标识选中的状态
    if (selected) {
        _selectedView.selected = NO;
    } else {
        _selectedView.selected = YES;
    }
}

- (void)changeSelectViewIconState {
    if (_selectedView.selected) {
        if ([self.delegate respondsToSelector:@selector(changeSelectedArrayWith:)]) {
            [self.delegate changeSelectedArrayWith:_selectedView.selected];
        }
        _selectedView.selected = NO;
    } else {
        if ([self.delegate respondsToSelector:@selector(changeSelectedArrayWith:)]) {
            [self.delegate changeSelectedArrayWith:_selectedView.selected];
        }
        _selectedView.selected = YES;
    }
}

- (void)buyButtonClick {
    if ([self.delegate respondsToSelector:@selector(buyButtonClick)]) {
        [self.delegate buyButtonClick];
    }
}

@end
