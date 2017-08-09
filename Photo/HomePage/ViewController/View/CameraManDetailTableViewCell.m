//
//  CameraManDetailTableViewCell.m
//  Photo
//
//  Created by malin  on 2017/8/9.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "CameraManDetailTableViewCell.h"
#import "Masonry.h"

@implementation CameraManDetailTableViewCell

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
    [self.contentView addSubview:self.memberView];
    [self.contentView addSubview:self.memberName];
    [self.contentView addSubview:self.commentContent];
}

- (void)setImmutableConstraints {
    [_memberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.width.equalTo(@(20));
        make.height.equalTo(@(20));
    }];
    
    [_memberName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_memberView);
        make.left.equalTo(_memberName.mas_right).with.offset(10);
    }];
    
    [_commentContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_memberView.mas_left);
        make.top.equalTo(_memberView.mas_bottom).with.offset(10);
    }];
}

#pragma mark --- getters and setters ---
- (UIImageView *)memberView {
    if (!_memberView) {
        _memberView = [[UIImageView alloc] init];
        _memberView.backgroundColor = [UIColor redColor];
    }
    return _memberView;
}

- (UILabel *)memberName {
    if (!_memberName) {
        _memberName = [[UILabel alloc] init];
        _memberName.text = @"memberName";
        [_memberName sizeToFit];
    }
    return _memberName;
}

- (UILabel *)commentContent {
    if (!_commentContent) {
        _commentContent = [[UILabel alloc] init];
        _commentContent.text = @"好评";
        [_commentContent sizeToFit];
    }
    return _commentContent;
}

@end
