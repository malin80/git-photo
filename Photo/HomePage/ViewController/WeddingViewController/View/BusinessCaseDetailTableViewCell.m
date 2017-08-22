//
//  BusinessCaseDetailTableViewCell.m
//  Photo
//
//  Created by malin  on 2017/8/22.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "BusinessCaseDetailTableViewCell.h"

@implementation BusinessCaseDetailTableViewCell

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
}

- (void)setImmutableConstraints {
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.bottom.equalTo(self.contentView);
    }];
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

@end
