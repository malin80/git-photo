//
//  CameraDetailTableViewCell.m
//  Photo
//
//  Created by malin  on 2017/8/3.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "CameraDetailTableViewCell.h"
#import "Masonry.h"

@implementation CameraDetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
        [self setImmutableConstraints];
    }
    return self;
}

- (void)initView {
    [self.contentView addSubview:self.teamImageView];
    [self.contentView addSubview:self.teamNameLabel];
    [self.contentView addSubview:self.teamDetailLabel];
    [self.contentView addSubview:self.teamPriceLabel];
}

- (void)setImmutableConstraints {
    [_teamImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).with.offset(5);
        make.width.equalTo(@(80));
        make.height.equalTo(@(80));
    }];
    
    [_teamNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView).with.offset(-20);
        make.left.equalTo(_teamImageView.mas_right).with.offset(20);
    }];
    
    [_teamDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView).with.offset(20);
        make.left.equalTo(_teamNameLabel);
    }];
}

#pragma mark --- getters and setters ---
- (UIImageView *)teamImageView {
    if (!_teamImageView) {
        _teamImageView = [[UIImageView alloc] init];
        _teamImageView.backgroundColor = [UIColor redColor];
    }
    return _teamImageView;
}

- (UILabel *)teamNameLabel {
    if (!_teamNameLabel) {
        _teamNameLabel = [[UILabel alloc] init];
        _teamNameLabel.text = @"teamImageView";
        [_teamNameLabel sizeToFit];
    }
    return _teamNameLabel;
}

- (UILabel *)teamDetailLabel {
    if (!_teamDetailLabel) {
        _teamDetailLabel = [[UILabel alloc] init];
        _teamDetailLabel.text = @"teamImageViewteamImageView";
    }
    return _teamDetailLabel;
}

- (UILabel *)teamPriceLabel {
    if (!_teamPriceLabel) {
        _teamPriceLabel = [[UILabel alloc] init];
        _teamPriceLabel.text = @"32423434钱";
    }
    return _teamPriceLabel;
}


@end
