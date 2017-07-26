//
//  UserDataTableViewCell.m
//  Photo
//
//  Created by malin  on 2017/7/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "UserDataTableViewCell.h"
#import "Masonry.h"

@implementation UserDataTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
        [self setImmutableConstraints];
    }
    return self;
}

- (void)initView {
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.content];
    [self.contentView addSubview:self.subtitle];
}

- (void)setImmutableConstraints {
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.centerY.equalTo(self.contentView);
    }];
    
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
    
    [_subtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
    }];
}

#pragma mark --- getters and setters ---
- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        [_title sizeToFit];
    }
    return _title;
}

- (UILabel *)content {
    if (!_content) {
        _content = [[UILabel alloc] init];
        [_content sizeToFit];
    }
    return _content;
}

- (UILabel *)subtitle {
    if (!_subtitle) {
        _subtitle = [[UILabel alloc] init];
        _subtitle.font = [UIFont systemFontOfSize:10];
        [_subtitle sizeToFit];
    }
    return _subtitle;
}

@end
