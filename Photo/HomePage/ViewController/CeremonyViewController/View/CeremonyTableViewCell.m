//
//  CeremonyTableViewCell.m
//  Photo
//
//  Created by malin  on 2017/9/1.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "CeremonyTableViewCell.h"

@implementation CeremonyTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
        [self setImmutableConstraints];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.titleView];
    [self addSubview:self.titleLabel];
}

- (void)setImmutableConstraints {
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.width.equalTo(@(ScreenWidth));
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom).with.offset(-30);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleView.mas_bottom).with.offset(5);
        make.left.equalTo(_titleView);
    }];
}

#pragma mark --- getters and setters 
- (UIImageView *)titleView {
    if (!_titleView) {
        _titleView = [[UIImageView alloc] init];
    }
    return _titleView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
//        _titleLabel.textColor  = [UIColor colorR:64 G:72 B:70 alpha:1];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

@end
