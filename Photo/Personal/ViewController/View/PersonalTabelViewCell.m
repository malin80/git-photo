//
//  PersonalTabelViewCell.m
//  Photo
//
//  Created by malin  on 2017/7/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "PersonalTabelViewCell.h"
#import "Masonry.h"

@implementation PersonalTabelViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
        [self setImmutableConstraints];
    }
    return self;
}

- (void)initView {
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.arrow];
}

- (void)setImmutableConstraints {
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(@(20));
        make.width.equalTo(@(20));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).with.offset(20);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@(100));
        make.height.equalTo(@(20));
    }];
    
    [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-15);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@(20));
        make.height.equalTo(@(20));
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
    }
    return _titleLabel;
}

- (UIImageView *)arrow {
    if (!_arrow) {
        _arrow = [[UIImageView alloc] init];
        _arrow.image = [UIImage imageNamed:@"personal_arrow"];
    }
    return _arrow;
}

@end
