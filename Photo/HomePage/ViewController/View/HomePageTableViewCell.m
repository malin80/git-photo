//
//  HomePageTableViewCell.m
//  Photo
//
//  Created by malin  on 2017/7/25.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "HomePageTableViewCell.h"
#import "Masonry.h"
#import "HomePageManager.h"

@implementation HomePageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
        [self setImmutableConstraints];
    }
    return self;
}

- (void)initView {
    [self.contentView addSubview:self.scrollView];
    [self.contentView addSubview:self.colorLabel];
    [self.contentView addSubview:self.title];
}

- (void)setImmutableConstraints {
    [_colorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(5);
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.height.equalTo(@(20));
        make.width.equalTo(@(5));
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_colorLabel);
        make.left.equalTo(_colorLabel.mas_right).with.offset(10);
    }];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_colorLabel);
        make.top.equalTo(_colorLabel.mas_bottom).with.offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.width.equalTo(@(ScreenWidth-10));
    }];
}

#pragma mark --- getters and setters ---
- (UIView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIView alloc] init];
    }
    return _scrollView;
}

- (UILabel *)colorLabel {
    if (!_colorLabel) {
        _colorLabel = [[UILabel alloc] init];
        _colorLabel.backgroundColor = [UIColor redColor];
    }
    return _colorLabel;
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"婚纱摄影";\
        [_title sizeToFit];
    }
    return _title;
}

@end
