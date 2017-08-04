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
    [self.contentView addSubview:self.deleteBackView];
    [self.deleteBackView addSubview:self.deleteView];
    [self.deleteBackView addSubview:self.deleteLabel];
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
    
    [_deleteBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodsPrice);
        make.right.equalTo(self.contentView.mas_right).with.offset(-15);
        make.height.equalTo(@(30));
        make.width.equalTo(@(80));
    }];
    
    [_deleteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_deleteBackView.mas_left).with.offset(5);
        make.height.equalTo(_deleteBackView);
        make.width.equalTo(@(20));
        make.top.equalTo(_deleteBackView.mas_top);
    }];
    
    [_deleteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_deleteBackView.mas_right).with.offset(-10);
        make.centerY.equalTo(_deleteBackView);
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
        _goodsName.textColor = [UIColor colorWithRed:26/255.0 green:34/255.0 blue:30/255.0 alpha:1.0];
        _goodsName.font = [UIFont systemFontOfSize:15];
        [_goodsName sizeToFit];
    }
    return _goodsName;
}

- (UILabel *)goodsParameter {
    if (!_goodsParameter) {
        _goodsParameter = [[UILabel alloc] init];
        _goodsParameter.text = @"产品参数";
        _goodsParameter.textColor = [UIColor colorWithRed:135/255.0 green:136/255.0 blue:138/255.0 alpha:1.0];
        _goodsParameter.font = [UIFont systemFontOfSize:12];
        [_goodsParameter sizeToFit];
    }
    return _goodsParameter;
}

- (UILabel *)goodsPrice {
    if (!_goodsPrice) {
        _goodsPrice = [[UILabel alloc] init];
        _goodsPrice.textColor = [UIColor colorWithRed:253/255.0 green:130/255.0 blue:38/255.0 alpha:1.0];
        _goodsPrice.font = [UIFont systemFontOfSize:15];
        [_goodsPrice sizeToFit];
    }
    return _goodsPrice;
}

- (UILabel *)goodsCount {
    if (!_goodsCount) {
        _goodsCount = [[UILabel alloc] init];
        _goodsParameter.textColor = [UIColor colorWithRed:82/255.0 green:86/255.0 blue:85/255.0 alpha:1.0];
        _goodsCount.font = [UIFont systemFontOfSize:15];
        [_goodsCount sizeToFit];
    }
    return _goodsCount;
}

- (UIView *)deleteBackView {
    if (!_deleteBackView) {
        _deleteBackView = [[UIView alloc] init];
    }
    return _deleteBackView;
}

- (UIImageView *)deleteView {
    if (!_deleteView) {
        UIImage *image = [UIImage imageNamed:@"shopping_delete"];
        _deleteView = [[UIImageView alloc] init];
        _deleteView.image = image;
    }
    return _deleteView;
}

- (UILabel *)deleteLabel {
    if (!_deleteLabel) {
        _deleteLabel = [[UILabel alloc] init];
        _deleteLabel.text = @"删除";
        _deleteLabel.font = [UIFont systemFontOfSize:13];
        _deleteLabel.textColor = [UIColor colorWithRed:130/255.0 green:132/255.0 blue:131/255.0 alpha:1.0];
        [_deleteLabel sizeToFit];
    }
    return _deleteLabel;
}

#pragma mark --- gestuer ---
//勾选按钮状态的改变
- (void)changeSelectViewIconState
{
    //标识选中的状态
    if (_selectedView.selected) {
        if ([self.delegate respondsToSelector:@selector(selectGoodsInfo)]) {
            _selectedView.selected = NO;
            [self.delegate selectedGoodsInfo];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(selectGoodsInfo)]) {
            _selectedView.selected = YES;
            [self.delegate selectGoodsInfo];
        }
    }
}

@end
