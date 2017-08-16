//
//  CameraManOrderTableViewCell.m
//  Photo
//
//  Created by malin  on 2017/8/16.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "CameraManOrderTableViewCell.h"
#import "Masonry.h"

@implementation CameraManOrderTableViewCell

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
    [self.contentView addSubview:self.groupNameLabel];
    [self.contentView addSubview:self.orderNumLabel];
    [self.contentView addSubview:self.orderCameraManNameLabel];
    [self.contentView addSubview:self.orderCreatDateLabel];
    [self.contentView addSubview:self.orderDateLabel];
    [self.contentView addSubview:self.orderStatusLabel];
    [self.contentView addSubview:self.buttonBackView];
    [self.buttonBackView addSubview:self.payButton];
    [self.buttonBackView addSubview:self.cancelButton];
    [self.buttonBackView addSubview:self.backButton];
    [self.buttonBackView addSubview:self.deleteButton];
}

- (void)setImmutableConstraints {
    [_groupNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
    }];
    
    [_orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_groupNameLabel);
        make.top.equalTo(_groupNameLabel.mas_bottom).with.offset(5);
    }];
    
    [_orderCameraManNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_orderNumLabel);
        make.top.equalTo(_orderNumLabel.mas_bottom).with.offset(5);
    }];
    
    [_orderCreatDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_orderCameraManNameLabel);
        make.top.equalTo(_orderCameraManNameLabel.mas_bottom).with.offset(5);
    }];
    
    [_orderDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_orderCreatDateLabel.mas_right).with.offset(20);
        make.top.equalTo(_orderCreatDateLabel);
    }];
    
    [_orderStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
        make.top.equalTo(_groupNameLabel);
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
- (UILabel *)groupNameLabel {
    if (!_groupNameLabel) {
        _groupNameLabel = [[UILabel alloc] init];
        _groupNameLabel.textColor = [UIColor colorWithRed:51/255.0 green:52/255.0 blue:59/255.0 alpha:1.0];
        [_groupNameLabel sizeToFit];
    }
    return _groupNameLabel;
}

- (UILabel *)orderNumLabel {
    if (!_orderNumLabel) {
        _orderNumLabel = [[UILabel alloc] init];
        _orderNumLabel.textColor = [UIColor colorWithRed:148/255.0 green:149/255.0 blue:151/255.0 alpha:1.0];
        [_orderNumLabel sizeToFit];
    }
    return _orderNumLabel;
}

- (UILabel *)orderCameraManNameLabel {
    if (!_orderCameraManNameLabel) {
        _orderCameraManNameLabel = [[UILabel alloc] init];
        _orderCameraManNameLabel.textColor = [UIColor colorWithRed:148/255.0 green:149/255.0 blue:151/255.0 alpha:1.0];
        [_orderCameraManNameLabel sizeToFit];
        
    }
    return _orderCameraManNameLabel;
}


- (UILabel *)orderCreatDateLabel {
    if (!_orderCreatDateLabel) {
        _orderCreatDateLabel = [[UILabel alloc] init];
        _orderCreatDateLabel.textColor = [UIColor colorWithRed:148/255.0 green:149/255.0 blue:151/255.0 alpha:1.0];
        [_orderCreatDateLabel sizeToFit];
    }
    return _orderCreatDateLabel;
}

- (UILabel *)orderDateLabel {
    if (!_orderDateLabel) {
        _orderDateLabel = [[UILabel alloc] init];
        _orderDateLabel.textColor = [UIColor colorWithRed:148/255.0 green:149/255.0 blue:151/255.0 alpha:1.0];
        [_orderDateLabel sizeToFit];
    }
    return _orderDateLabel;
}

- (UILabel *)orderStatusLabel {
    if (!_orderStatusLabel) {
        _orderStatusLabel = [[UILabel alloc] init];
        _orderStatusLabel.textColor = [UIColor colorWithRed:148/255.0 green:149/255.0 blue:151/255.0 alpha:1.0];
        [_orderStatusLabel sizeToFit];
    }
    return _orderStatusLabel;
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
