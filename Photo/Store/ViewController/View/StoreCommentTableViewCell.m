//
//  StoreCommentTableViewCell.m
//  Photo
//
//  Created by malin  on 2017/8/11.
//  Copyright © 2017年 malin . All rights reserved.
//

#define kImageViewWidth  (ScreenWidth - 60)/3

#import "StoreCommentTableViewCell.h"
#import "SDWebImageCache.h"

@implementation StoreCommentTableViewCell

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
    [self.contentView addSubview:self.memberView];
    [self.contentView addSubview:self.memberName];
    [self.contentView addSubview:self.commentContent];
}

- (void)setImmutableConstraints {
    [_memberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
        make.width.equalTo(@(30));
        make.height.equalTo(@(30));
    }];
    
    [_memberName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_memberView);
        make.left.equalTo(_memberView.mas_right).with.offset(10);
    }];
}

-(void)setCommentContentText:(NSString*)text withCommentImageUrl:(NSString *)url {
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
    self.commentContent.text = text;
    //设置label的最大行数
    self.commentContent.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:text];
    self.commentContent.attributedText = attrStr;
    NSRange range = NSMakeRange(0, attrStr.length);
    NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];   // 获取该段attributedString的属性字典
    // 计算文本的大小
    CGSize labelSize = [self.commentContent.text boundingRectWithSize:self.commentContent.bounds.size // 用于计算文本绘制时占据的矩形块
                                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                               attributes:dic        // 文字的属性
                                                  context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    int lines = labelSize.width/ScreenWidth;

    self.commentContent.frame = CGRectMake(20, 45, ScreenWidth-20, labelSize.height*(lines+3));
    self.commentContent.numberOfLines = 10;
    
    NSArray *temp=[url componentsSeparatedByString:@";"];
    if (temp.count == 1) {
        frame.size.height = labelSize.height*(lines+3)+40;
        self.frame = frame;
        return;
    } else if (temp.count <= 3) {
        frame.size.height = labelSize.height*(lines+3)+160;
        self.frame = frame;
        return;
    } else if (temp.count <= 6) {
        frame.size.height = labelSize.height*(lines+3)+280;
        self.frame = frame;
        return;
    } else {
        frame.size.height = labelSize.height*(lines+3)+280;
        self.frame = frame;
        return;
    }
    //计算出自适应的高度
}

- (void)createCommentImageWithUrl:(NSString *)url {
    self.temp = [url componentsSeparatedByString:@";"];
    if (self.temp.count > 0) {
        for (int i = 0; i<self.temp.count; i++) {
            UIButton *imageView = [[UIButton alloc] init];
            imageView.tag = i;
            [imageView addTarget:self action:@selector(touchImageView:) forControlEvents:UIControlEventTouchUpInside];
            [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,self.temp[i]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                [imageView setImage:image forState:UIControlStateNormal];
            }];
            [self.contentView addSubview:imageView];
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_commentContent.mas_bottom).with.offset(i/3 * (kImageViewWidth + 10));
                make.left.equalTo(self.contentView.mas_left).with.offset(20+i%3*(kImageViewWidth+10));
                make.height.equalTo(@(kImageViewWidth));
                make.width.equalTo(@(kImageViewWidth));
            }];
        }
    }
}

- (void)touchImageView:(UIButton *)sender {
    NSMutableArray *mary=[[NSMutableArray alloc]init];
    for (int i=0;  i<self.temp.count;i++) {
        [mary addObject:[NSString stringWithFormat:@"%@%@",baseUrl,self.temp[i]]];
    }
    if ([self.delegate respondsToSelector:@selector(touchCommentImage: select:)]) {
        [self.delegate touchCommentImage:mary select:sender.tag];
    }
}


#pragma mark --- getters and setters ---
- (UIImageView *)memberView {
    if (!_memberView) {
        _memberView = [[UIImageView alloc] init];
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
    }
    return _commentContent;
}

@end
