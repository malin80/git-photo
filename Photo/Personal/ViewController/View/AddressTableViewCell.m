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
        self.contentView.backgroundColor = [UIColor grayColor];
    }
    return self;
}

- (void)initView {
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.phoneLabel];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.selectView];
    [self.contentView addSubview:self.normalAddressLabel];
    [self.contentView addSubview:self.editBackView];
    [self.editBackView addSubview:self.editImageView];
    [self.editBackView addSubview:self.editLabel];
    [self.contentView addSubview:self.deleteBackView];
    [self.deleteBackView addSubview:self.deleteImageView];
    [self.deleteBackView addSubview:self.deleteLabel];

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
    
    [_selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom).with.offset(12);
        make.width.equalTo(@(15));
        make.height.equalTo(@(15));
        make.left.equalTo(_nameLabel);
    }];
    
    [_normalAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_selectView);
        make.left.equalTo(_selectView.mas_right).equalTo(@(5));
    }];
    
    [_editBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom).with.offset(5);
        make.centerX.equalTo(self.contentView).with.offset(10);
        make.width.equalTo(@(80));
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

- (UIImageView *)selectView {
    if (!_selectView) {
        _selectView = [[UIImageView alloc] init];
        _selectView.backgroundColor = [UIColor redColor];
    }
    return _selectView;
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
        _editBackView.backgroundColor = [UIColor clearColor];
        _editBackView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoEdit)];
        [_editBackView addGestureRecognizer:tap];
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
        _deleteBackView.backgroundColor = [UIColor clearColor];
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

#pragma mark --- gestuer ---
- (void)gotoEdit {
    if ([self.delegate respondsToSelector:@selector(editAddress)]) {
        [self.delegate editAddress];
    }
}


@end
