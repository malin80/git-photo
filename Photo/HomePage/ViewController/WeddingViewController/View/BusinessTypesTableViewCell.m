//
//  BusinessTypesTableViewCell.m
//  Photo
//
//  Created by malin  on 2017/8/22.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "BusinessTypesTableViewCell.h"

@implementation BusinessTypesTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorR:255 G:255 B:255 alpha:1];
        [self initView];
        [self setImmutableConstraints];
    }
    return self;
}

- (void)initView {
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.countLabel];
    [self.contentView addSubview:self.casePriceLabel];
    [self.contentView addSubview:self.tagLabel];
}

- (void)setImmutableConstraints {
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(5);
        make.right.equalTo(self.contentView.mas_right).with.offset(-5);
        make.height.equalTo(@(80));
        make.top.equalTo(self.contentView.mas_top).with.offset(5);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconView.mas_left);
        make.top.equalTo(_iconView.mas_bottom).with.offset(10);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_iconView.mas_right);
        make.top.equalTo(_titleLabel);
    }];
    
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconView.mas_left);
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(20);
    }];
    
    [_casePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_iconView.mas_right);
        make.top.equalTo(_titleLabel);
    }];
    
    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconView.mas_left);
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(20);
    }];
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor  = [UIColor colorR:64 G:72 B:70 alpha:1];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textColor  = [UIColor colorR:64 G:72 B:70 alpha:1];
        _priceLabel.font = [UIFont systemFontOfSize:14];
        _priceLabel.hidden = YES;
        [_priceLabel sizeToFit];
    }
    return _priceLabel;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.textColor  = [UIColor colorR:64 G:72 B:70 alpha:1];
        _countLabel.font = [UIFont systemFontOfSize:14];
        _countLabel.hidden = YES;
        [_countLabel sizeToFit];
    }
    return _countLabel;
}

- (UILabel *)casePriceLabel {
    if (!_casePriceLabel) {
        _casePriceLabel = [[UILabel alloc] init];
        _casePriceLabel.textColor  = [UIColor colorR:64 G:72 B:70 alpha:1];
        _casePriceLabel.font = [UIFont systemFontOfSize:14];
        _casePriceLabel.hidden = YES;
        [_casePriceLabel sizeToFit];
    }
    return _casePriceLabel;
}

- (UILabel *)tagLabel {
    if (!_tagLabel) {
        _tagLabel = [[UILabel alloc] init];
        _tagLabel.textColor  = [UIColor colorR:64 G:72 B:70 alpha:1];
        _tagLabel.font = [UIFont systemFontOfSize:14];
        _tagLabel.hidden = YES;
        [_tagLabel sizeToFit];
    }
    return _tagLabel;
}
@end
