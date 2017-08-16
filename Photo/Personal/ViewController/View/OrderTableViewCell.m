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
        self.contentView.backgroundColor = [UIColor colorR:250 G:250 B:250 alpha:1];
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
    [self.contentView addSubview:self.buttonBackView];
    [self.buttonBackView addSubview:self.payButton];
    [self.buttonBackView addSubview:self.cancelButton];
    [self.buttonBackView addSubview:self.backButton];
    [self.buttonBackView addSubview:self.deleteButton];
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
    
    [_buttonBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left);
        make.height.equalTo(@(30));
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    [_payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_buttonBackView.mas_right).with.offset(-10);
        make.height.equalTo(@(30));
        make.width.equalTo(@(60));
        make.bottom.equalTo(_buttonBackView.mas_bottom);
    }];
    
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_payButton.mas_left);
        make.height.equalTo(@(30));
        make.width.equalTo(@(80));
        make.bottom.equalTo(_buttonBackView.mas_bottom);
    }];

    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_buttonBackView.mas_right);
        make.height.equalTo(@(30));
        make.width.equalTo(@(80));
        make.bottom.equalTo(_buttonBackView.mas_bottom);
    }];

    [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_buttonBackView.mas_right);
        make.height.equalTo(@(30));
        make.width.equalTo(@(80));
        make.bottom.equalTo(_buttonBackView.mas_bottom);
    }];
}

#pragma mark --- getters and setters ---
- (UIImageView *)goodsImage {
    if (!_goodsImage) {
        _goodsImage = [[UIImageView alloc] init];
        _goodsImage.backgroundColor = [UIColor clearColor];
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
        _goodsState.textColor = [UIColor colorWithRed:206/255.0 green:84/255.0 blue:95/255.0 alpha:1.0];
        [_goodsState sizeToFit];
    }
    return _goodsState;
}

- (UIView *)buttonBackView {
    if (!_buttonBackView) {
        _buttonBackView = [[UIView alloc] init];
        _buttonBackView.backgroundColor = [UIColor whiteColor];
    }
    return _buttonBackView;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [[UIButton alloc] init];
        _backButton.layer.borderWidth = 0.5;
        _backButton.layer.borderColor = [[UIColor colorR:247 G:223 B:200 alpha:1] CGColor];
        _backButton.layer.cornerRadius = 10;
        [_backButton setTitle:@"申请退单" forState:UIControlStateNormal];
        _backButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_backButton setTitleColor:[UIColor colorR:241 G:111 B:0 alpha:1] forState:UIControlStateNormal];
        _backButton.hidden = YES;
        [_backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] init];
        _cancelButton.layer.borderWidth = 0.5;
        _cancelButton.layer.borderColor = [[UIColor colorR:243 G:243 B:243 alpha:1] CGColor];
        _cancelButton.layer.cornerRadius = 10;
        [_cancelButton setTitle:@"取消订单" forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_cancelButton setTitleColor:[UIColor colorR:60 G:63 B:61 alpha:1] forState:UIControlStateNormal];
        _cancelButton.hidden = YES;
        [_cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)payButton {
    if (!_payButton) {
        _payButton = [[UIButton alloc] init];
        _payButton.layer.borderWidth = 0.5;
        _payButton.layer.borderColor = [[UIColor colorR:247 G:223 B:200 alpha:1] CGColor];
        _payButton.layer.cornerRadius = 10;
        [_payButton setTitle:@"付款" forState:UIControlStateNormal];
        _payButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_payButton setTitleColor:[UIColor colorR:241 G:111 B:0 alpha:1] forState:UIControlStateNormal];
        _payButton.hidden = YES;
        [_payButton addTarget:self action:@selector(payButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payButton;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc] init];
        _deleteButton.layer.borderWidth = 0.5;
        _deleteButton.layer.borderColor = [[UIColor colorR:243 G:243 B:243 alpha:1] CGColor];
        _deleteButton.layer.cornerRadius = 10;
        [_deleteButton setTitle:@"删除订单" forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_deleteButton setTitleColor:[UIColor colorR:60 G:63 B:61 alpha:1] forState:UIControlStateNormal];
        _deleteButton.hidden = YES;
        [_deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

#pragma mark --- button method ---
- (void)backButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(backButtonClick:)]) {
        [self.delegate backButtonClick:sender];
    }
}

- (void)cancelButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(cancelButtonClick:)]) {
        [self.delegate cancelButtonClick:sender];
    }
}

- (void)payButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(payButtonClick:)]) {
        [self.delegate payButtonClick:sender];
    }
}

- (void)deleteButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(deleteButtonClick:)]) {
        [self.delegate deleteButtonClick:sender];
    }
}

@end
