//
//  WeddingTableViewCell.m
//  Photo
//
//  Created by malin  on 2017/8/17.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "WeddingTableViewCell.h"
#import "Masonry.h"

@implementation WeddingTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorR:250 G:250 B:250 alpha:1];
        [self initView];
        [self setImmutableConstraints];
    }
    return self;
}

- (void)initView {
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.subTitle1Label];
    [self.contentView addSubview:self.subTitle2Label];
}

- (void)setImmutableConstraints {
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(5);
        make.top.equalTo(self.contentView.mas_top).with.offset(5);
        make.width.equalTo(@(80));
        make.height.equalTo(@(80));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).with.offset(5);
        make.top.equalTo(_icon.mas_top).with.offset(10);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(10);
    }];
    
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.top.equalTo(_priceLabel.mas_bottom).with.offset(5);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_icon.mas_bottom);
        make.left.equalTo(_titleLabel);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(@(1));
    }];
    
    [_subTitle1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.top.equalTo(_line.mas_bottom).with.offset(10);
    }];
    
    [_subTitle2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.top.equalTo(_subTitle1Label.mas_bottom).with.offset(10);
    }];
}

#pragma mark --- getters and setters ---
- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
    }
    return _icon;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorR:87 G:89 B:88 alpha:1];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textColor = [UIColor colorR:87 G:89 B:88 alpha:1];
        _priceLabel.font = [UIFont systemFontOfSize:14];
        [_priceLabel sizeToFit];
    }
    return _priceLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textColor = [UIColor colorR:162 G:162 B:162 alpha:1];
        _detailLabel.font = [UIFont systemFontOfSize:14];
        [_detailLabel sizeToFit];
    }
    return _detailLabel;
}

- (UILabel *)line {
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = [UIColor colorR:235 G:235 B:235 alpha:1];
    }
    return _line;
}

- (UILabel *)subTitle1Label {
    if (!_subTitle1Label) {
        _subTitle1Label = [[UILabel alloc] init];
        _subTitle1Label.textColor = [UIColor colorR:162 G:162 B:162 alpha:1];
        _subTitle1Label.font = [UIFont systemFontOfSize:14];
        [_subTitle1Label sizeToFit];
    }
    return _subTitle1Label;
}

- (UILabel *)subTitle2Label {
    if (!_subTitle2Label) {
        _subTitle2Label = [[UILabel alloc] init];
        _subTitle2Label.textColor = [UIColor colorR:162 G:162 B:162 alpha:1];
        _subTitle2Label.font = [UIFont systemFontOfSize:14];
        [_subTitle2Label sizeToFit];
    }
    return _subTitle2Label;
}

@end
