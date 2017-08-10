//
//  CameraManDetailTableViewCell.m
//  Photo
//
//  Created by malin  on 2017/8/9.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "CameraManDetailTableViewCell.h"
#import "Masonry.h"
#import "CameraManager.h"

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
    
    NSArray *temp=[GET_SINGLETON_FOR_CLASS(CameraManager).commentImages componentsSeparatedByString:@";"];
    for (int i = 0; i<temp.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseUrl,temp[i]]];
        UIImage *imgFromUrl =[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
        imageView.image = imgFromUrl;
        [self.contentView addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_commentContent.mas_bottom).with.offset(10);
            make.left.equalTo(_commentContent.mas_left).with.offset(i*120);
            make.height.equalTo(@(100));
            make.width.equalTo(@(100));
        }];
    }
}

- (void)setImmutableConstraints {
    [_memberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.width.equalTo(@(30));
        make.height.equalTo(@(30));
    }];
    
    [_memberName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_memberView);
        make.left.equalTo(_memberView.mas_right).with.offset(10);
    }];
    
    [_commentContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_memberView.mas_left);
        make.top.equalTo(_memberView.mas_bottom).with.offset(10);
        make.height.equalTo(@(100));
        make.width.equalTo(@(ScreenWidth-20));
    }];
}

- (CGFloat)calculateCellHeight:(NSDictionary *)dict {
    CGFloat height = 0.0f;
    CGFloat randomHeight = 0.0f;
    NSString *commentText = [dict objectForKey:@"commentText"];
    _commentContent.text = commentText;
    if (commentText.length < 20) {
        randomHeight = 80.0f;
        [_commentContent mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(20));
        }];
    } else if (commentText.length >=20 && commentText.length < 40) {
        randomHeight = 100.0f;
        [_commentContent mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(50));
        }];
    } else if (commentText.length >=40 && commentText.length < 60) {
        randomHeight = 120.0f;
        [_commentContent mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(80));
        }];

    }
    
    NSString *commentImgs = [dict objectForKey:@"commentImgs"];
    NSArray *temp=[commentImgs componentsSeparatedByString:@";"];
    
    if (temp.count > 0) {
        height = 140 + randomHeight;
    } else {
        height = randomHeight;
    }
    return height;
}

#pragma mark --- getters and setters ---
- (UIImageView *)memberView {
    if (!_memberView) {
        _memberView = [[UIImageView alloc] init];
        _memberView.backgroundColor = [UIColor redColor];
        _memberView.layer.cornerRadius = 15;
    }
    return _memberView;
}

- (UILabel *)memberName {
    if (!_memberName) {
        _memberName = [[UILabel alloc] init];
        [_memberName sizeToFit];
    }
    return _memberName;
}

- (UILabel *)commentContent {
    if (!_commentContent) {
        _commentContent = [[UILabel alloc] init];
        _commentContent.lineBreakMode = NSLineBreakByWordWrapping;
        _commentContent.numberOfLines = 10;
        _commentContent.textAlignment = NSTextAlignmentLeft;
        [_commentContent sizeToFit];
    }
    return _commentContent;
}

@end
