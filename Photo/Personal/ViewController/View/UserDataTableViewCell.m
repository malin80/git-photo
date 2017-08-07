//
//  UserDataTableViewCell.m
//  Photo
//
//  Created by malin  on 2017/7/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "UserDataTableViewCell.h"
#import "Masonry.h"
#import "LoginManager.h"

@implementation UserDataTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.info = GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo;

        [self initView];
        [self setImmutableConstraints];
    }
    return self;
}

- (void)initView {
    [self.contentView addSubview:self.avatarView];
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.content];
    [self.contentView addSubview:self.subtitle];
}

- (void)setImmutableConstraints {
    [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).with.offset(-80);
        make.width.equalTo(@(54));
        make.height.equalTo(@(54));
    }];
    
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
- (UIImageView *)avatarView {
    if (!_avatarView) {
        _avatarView = [[AvatarView alloc] init];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseUrl,self.info.memberPic]];
        UIImage *imgFromUrl =[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
        _avatarView.image = imgFromUrl;
        _avatarView.layer.masksToBounds = YES;
        _avatarView.layer.cornerRadius = 54/2;
        _avatarView.hidden = YES;
    }
    return _avatarView;
}

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
