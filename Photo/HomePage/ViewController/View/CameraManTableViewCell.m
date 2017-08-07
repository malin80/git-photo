//
//  CameraManTableViewCell.m
//  Photo
//
//  Created by malin  on 2017/8/3.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "CameraManTableViewCell.h"
#import "Masonry.h"

@implementation CameraManTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorR:229 G:229 B:229 alpha:1];
        [self initView];
        [self setImmutableConstraints];
    }
    return self;
}

- (void)initView {
    [self.contentView addSubview:self.cameraManImage];
    [self.contentView addSubview:self.name];
    [self.contentView addSubview:self.content];
    [self.contentView addSubview:self.works];
    [self.contentView addSubview:self.subscribeCount];
    [self.contentView addSubview:self.commentCount];
}

- (void)setImmutableConstraints {
    [_cameraManImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(@(80));
        make.width.equalTo(@(80));
    }];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cameraManImage.mas_top);
        make.left.equalTo(_cameraManImage.mas_right).with.offset(30);
    }];
    
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_name.mas_bottom).with.offset(15);
        make.left.equalTo(_name);
    }];
    
    [_works mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_content.mas_bottom).with.offset(15);
        make.left.equalTo(_name);
    }];
    
    [_subscribeCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_works.mas_right).with.offset(20);
        make.top.equalTo(_works);
    }];
    
    [_commentCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_subscribeCount.mas_right).with.offset(20);
        make.top.equalTo(_subscribeCount);
    }];
}

#pragma mark --- getters and setters ---
- (UIImageView *)cameraManImage {
    if (!_cameraManImage) {
        _cameraManImage = [[UIImageView alloc] init];
    }
    return _cameraManImage;
}

- (UILabel *)name {
    if (!_name) {
        _name = [[UILabel alloc] init];
        [_name sizeToFit];
    }
    return _name;
}

- (UILabel *)content {
    if (!_content) {
        _content = [[UILabel alloc] init];
        [_content sizeToFit];
    }
    return _content;
}

- (UILabel *)works {
    if (!_works) {
        _works = [[UILabel alloc] init];
        [_works sizeToFit];
    }
    return _works;
}

- (UILabel *)subscribeCount {
    if (!_subscribeCount) {
        _subscribeCount = [[UILabel alloc] init];
        [_subscribeCount sizeToFit];
    }
    return _subscribeCount;
}

- (UILabel *)commentCount {
    if (!_commentCount) {
        _commentCount = [[UILabel alloc] init];
        [_commentCount sizeToFit];
    }
    return _commentCount;
}

@end
