//
//  AddressTableViewCell.m
//  Photo
//
//  Created by malin  on 2017/7/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "AddressTableViewCell.h"
#import "Masonry.h"

@implementation AddressTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
        [self setImmutableConstraints];
        self.contentView.backgroundColor = UIColorFromRGB(250, 250, 250, 1);
    }
    return self;
}

- (void)initView {
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.phoneLabel];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.selectedView];
    [self.contentView addSubview:self.normalAddressLabel];
    [self.contentView addSubview:self.editBackView];
    [self.editBackView addSubview:self.editImageView];
    [self.editBackView addSubview:self.editLabel];
    [self.contentView addSubview:self.deleteBackView];
    [self.deleteBackView addSubview:self.deleteImageView];
    [self.deleteBackView addSubview:self.deleteLabel];
    [self.contentView addSubview:self.seperateView];

}

- (void)setImmutableConstraints {
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(5);
        make.top.equalTo(self.contentView.mas_top).with.offset(5);
    }];
    
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-40);
        make.top.equalTo(_nameLabel);
    }];
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.top.equalTo(_nameLabel.mas_bottom).with.offset(5);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addressLabel.mas_bottom).with.offset(5);
        make.width.equalTo(@([[UIScreen mainScreen] bounds].size.width));
        make.height.equalTo(@(1));
    }];
    
    [_selectedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom).with.offset(12);
        make.width.equalTo(@(15));
        make.height.equalTo(@(15));
        make.left.equalTo(_nameLabel);
    }];
    
    [_normalAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_selectedView);
        make.left.equalTo(_selectedView.mas_right).equalTo(@(5));
    }];
    
    [_editBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom).with.offset(12);
        make.centerX.equalTo(self.contentView).with.offset(10);
        make.width.equalTo(@(100));
        make.height.equalTo(@(30));
    }];
    
    [_editImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_editBackView);
        make.left.equalTo(_editBackView.mas_left).with.offset(5);
        make.width.equalTo(@(20));
        make.height.equalTo(@(25));
    }];
    
    [_editLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_editBackView);
        make.right.equalTo(_editBackView.mas_right).with.offset(-15);
    }];
    
    [_deleteBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_editBackView);
        make.left.equalTo(_editBackView.mas_right).with.offset(10);
        make.width.equalTo(@(80));
        make.height.equalTo(@(30));
    }];
    
    [_deleteImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_deleteBackView);
        make.left.equalTo(_deleteBackView.mas_left).with.offset(5);
        make.width.equalTo(@(20));
        make.height.equalTo(@(25));
    }];
    
    [_deleteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_deleteBackView);
        make.right.equalTo(_deleteBackView.mas_right).with.offset(-15);
    }];
    
    [_seperateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@(20));
    }];
}

#pragma mark --- getters and setters ---
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"namelabel";
        [_nameLabel sizeToFit];
    }
    return _nameLabel;
}

- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.text = @"13885229434";
        [_phoneLabel sizeToFit];
    }
    return _phoneLabel;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.text = @"sldjfiewj ojodsf e";
        [_addressLabel sizeToFit];
    }
    return _addressLabel;
}

- (UILabel *)line {
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = [UIColor darkGrayColor];
    }
    return _line;
}

- (UIButton *)selectedView
{
    if (!_selectedView) {
        _selectedView = [[UIButton alloc] init];
        [_selectedView setBackgroundImage:[UIImage imageNamed:@"personal_address_unselect"] forState:UIControlStateNormal];
        [_selectedView setBackgroundImage:[UIImage imageNamed:@"personal_address_selected"] forState:UIControlStateSelected];
        [_selectedView addTarget:self action:@selector(changeSelectViewIconState) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectedView;
}


- (UILabel *)normalAddressLabel {
    if (!_normalAddressLabel) {
        _normalAddressLabel = [[UILabel alloc] init];
        _normalAddressLabel.text = @"设为默认";
        _normalAddressLabel.font = [UIFont systemFontOfSize:12];
    }
    return _normalAddressLabel;
}

- (UIView *)editBackView {
    if (!_editBackView) {
        _editBackView = [[UIView alloc] init];
        _editBackView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        _editBackView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoEdit)];
        [_editBackView addGestureRecognizer:tap];
        _editBackView.layer.cornerRadius = 50.f;
    }
    return _editBackView;
}

- (UIImageView *)editImageView {
    if (!_editImageView) {
        UIImage *image = [UIImage imageNamed:@"personal_address_edit"];
        _editImageView = [[UIImageView alloc] init];
        _editImageView.image = image;
    }
    return _editImageView;
}

- (UILabel *)editLabel {
    if (!_editLabel) {
        _editLabel = [[UILabel alloc] init];
        _editLabel.text = @"编辑";
        _editLabel.font = [UIFont systemFontOfSize:12];
        _editLabel.textColor = [UIColor blueColor];
        [_editLabel sizeToFit];
    }
    return _editLabel;
}

- (UIView *)deleteBackView {
    if (!_deleteBackView) {
        _deleteBackView = [[UIView alloc] init];
        _deleteBackView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    }
    return _deleteBackView;
}

- (UIImageView *)deleteImageView {
    if (!_deleteImageView) {
        UIImage *image = [UIImage imageNamed:@"personal_address_delete"];
        _deleteImageView = [[UIImageView alloc] init];
        _deleteImageView.image = image;
    }
    return _deleteImageView;
}

- (UILabel *)deleteLabel {
    if (!_deleteLabel) {
        _deleteLabel = [[UILabel alloc] init];
        _deleteLabel.text = @"删除";
        _deleteLabel.font = [UIFont systemFontOfSize:12];
        _deleteLabel.textColor = [UIColor blueColor];
        [_deleteLabel sizeToFit];
    }
    return _deleteLabel;
}

- (UIView *)seperateView {
    if (!_seperateView) {
        _seperateView = [[UIView alloc] init];
        _seperateView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    }
    return _seperateView;
}

#pragma mark --- gestuer ---
- (void)gotoEdit {
    if ([self.delegate respondsToSelector:@selector(editAddress)]) {
        [self.delegate editAddress];
    }
}
//
////勾选按钮状态的改变
//- (void)changeSelectViewIconState
//{
//    //标识选中的状态
//    if (_selectedView.selected) {
//        _selectedView.selected = NO;
//        _normalAddressLabel.text = @"设为默认";
//    } else {
//        _selectedView.selected = YES;
//        _normalAddressLabel.text = @"默认地址";
//    }
//}

@end
