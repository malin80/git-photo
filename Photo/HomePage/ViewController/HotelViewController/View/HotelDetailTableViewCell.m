//
//  HotelDetailTableViewCell.m
//  Photo
//
//  Created by malin  on 2017/8/25.
//  Copyright © 2017年 malin . All rights reserved.
//

#define kImageViewWidth  (ScreenWidth - 60)/3

#import "HotelDetailTableViewCell.h"
#import "SDWebImageCache.h"

@implementation HotelDetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
        [self setImmutableConstraints];
    }
    return self;
}

- (void)initView
{
    [self addSubview:self.giftIcon];
    [self addSubview:self.titleLabel];
    [self.contentView addSubview:self.arrow];
}

- (void)setImmutableConstraints{
    [_giftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.centerY.equalTo(self);
        make.height.equalTo(@(20));
        make.width.equalTo(@(20));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_giftIcon.mas_right).with.offset(20);
        make.centerY.equalTo(self);
    }];

    [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-15);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@(15));
        make.height.equalTo(@(15));
    }];
}

#pragma mark --- getters and setters ---
//HotelDetailTableViewCell
- (UILabel *)giftIcon {
    if (!_giftIcon) {
        _giftIcon = [[UILabel alloc] init];
        _giftIcon.text = @"礼";
        _giftIcon.font = [UIFont systemFontOfSize:12];
        _giftIcon.textColor = [UIColor whiteColor];
        _giftIcon.textAlignment = NSTextAlignmentCenter;
        _giftIcon.backgroundColor = [UIColor colorR:116 G:187 B:246 alpha:1];
    }
    return _giftIcon;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor colorR:73 G:73 B:73 alpha:1];
    }
    return _titleLabel;
}

- (UIImageView *)arrow {
    if (!_arrow) {
        _arrow = [[UIImageView alloc] init];
        _arrow.image = [UIImage imageNamed:@"personal_arrow"];
    }
    return _arrow;
}

@end

@implementation HotelDetailSecondTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
        [self setImmutableConstraints];
    }
    return self;
}

- (void)initView
{
    [self addSubview:self.titleIcon];
    [self addSubview:self.titleLabel];
    [self addSubview:self.arrow];
    [self addSubview:self.subTitle];
}

- (void)setImmutableConstraints{
    [_titleIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.centerY.equalTo(self);
        make.height.equalTo(@(20));
        make.width.equalTo(@(20));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleIcon.mas_right).with.offset(20);
        make.centerY.equalTo(self);
    }];
    
    [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.centerY.equalTo(self);
        make.width.equalTo(@(15));
        make.height.equalTo(@(15));
    }];
    
    [_subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(_arrow.mas_left).with.offset(-10);
    }];
}

#pragma mark --- getters and setters ---
- (UIImageView *)titleIcon {
    if (!_titleIcon) {
        _titleIcon = [[UIImageView alloc] init];
    }
    return _titleIcon;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor colorR:73 G:73 B:73 alpha:1];
    }
    return _titleLabel;
}

- (UIImageView *)arrow {
    if (!_arrow) {
        _arrow = [[UIImageView alloc] init];
        _arrow.image = [UIImage imageNamed:@"personal_arrow"];
    }
    return _arrow;
}

- (UILabel *)subTitle {
    if (!_subTitle) {
        _subTitle = [[UILabel alloc] init];
        _subTitle.font = [UIFont systemFontOfSize:12];
        _subTitle.textColor = [UIColor colorR:198 G:198 B:198 alpha:1];
        _subTitle.hidden = YES;
    }
    return _subTitle;
}

@end

@implementation HotelDetailThirdTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
        [self setImmutableConstraints];
    }
    return self;
}

- (void)initView
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.line];
    [self addSubview:self.hallImageView];
    [self addSubview:self.hallNameLabel];
    [self addSubview:self.hallContainLabel];
    [self addSubview:self.hallHeight];
}

- (void)setImmutableConstraints{
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(20);
        make.top.equalTo(self.mas_top).with.offset(10);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(ScreenWidth));
        make.height.equalTo(@(1));
        make.left.equalTo(self.mas_left);
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(5);
    }];
    
    [_hallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.width.equalTo(@(60));
        make.height.equalTo(@(60));
        make.top.equalTo(_line.mas_bottom).with.offset(10);
    }];
    
    [_hallNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_hallImageView.mas_top);
        make.left.equalTo(_hallImageView.mas_right).with.offset(10);
    }];
    
    [_hallContainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_hallImageView);
        make.left.equalTo(_hallNameLabel);
    }];
    
    [_hallHeight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_hallNameLabel);
        make.bottom.equalTo(_hallImageView.mas_bottom);
    }];
}

#pragma mark --- getters and setters ---
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor colorR:73 G:73 B:73 alpha:1];
    }
    return _titleLabel;
}

- (UILabel *)line {
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = [UIColor colorR:250 G:250 B:250 alpha:1];
    }
    return _line;
}

- (UIImageView *)hallImageView {
    if (!_hallImageView) {
        _hallImageView = [[UIImageView alloc] init];
    }
    return _hallImageView;
}

- (UILabel *)hallNameLabel {
    if (!_hallNameLabel) {
        _hallNameLabel = [[UILabel alloc] init];
        _hallNameLabel.font = [UIFont systemFontOfSize:12];
    }
    return _hallNameLabel;
}

- (UILabel *)hallContainLabel {
    if (!_hallContainLabel) {
        _hallContainLabel = [[UILabel alloc] init];
        _hallContainLabel.font = [UIFont systemFontOfSize:12];
    }
    return _hallContainLabel;
}

- (UILabel *)hallHeight {
    if (!_hallHeight) {
        _hallHeight = [[UILabel alloc] init];
        _hallHeight.font = [UIFont systemFontOfSize:12];
    }
    return _hallHeight;
}

@end

@implementation HotelDetailFourthTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
        [self setImmutableConstraints];
    }
    return self;
}

- (void)initView
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.arrow];
    [self addSubview:self.subTitle];
}

- (void)setImmutableConstraints{
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(20);
        make.centerY.equalTo(self);
    }];
    
    [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.centerY.equalTo(self);
        make.width.equalTo(@(15));
        make.height.equalTo(@(15));
    }];
    
    [_subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(_arrow.mas_left).with.offset(-10);
    }];
}

#pragma mark --- getters and setters ---
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor colorR:73 G:73 B:73 alpha:1];
    }
    return _titleLabel;
}

- (UIImageView *)arrow {
    if (!_arrow) {
        _arrow = [[UIImageView alloc] init];
        _arrow.image = [UIImage imageNamed:@"personal_arrow"];
    }
    return _arrow;
}

- (UILabel *)subTitle {
    if (!_subTitle) {
        _subTitle = [[UILabel alloc] init];
        _subTitle.font = [UIFont systemFontOfSize:12];
        _subTitle.textColor = [UIColor colorR:198 G:198 B:198 alpha:1];
    }
    return _subTitle;
}

@end

@implementation HotelDetailFifthTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
        [self setImmutableConstraints];
    }
    return self;
}

- (void)initView
{
    [self.contentView addSubview:self.memberView];
    [self.contentView addSubview:self.memberName];
    [self.contentView addSubview:self.commentContent];
    [self.contentView addSubview:self.commentGardeView];
}

- (void)setImmutableConstraints{
    [_memberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
        make.width.equalTo(@(40));
        make.height.equalTo(@(40));
    }];
    
    [_memberName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_memberView).with.offset(-10);
        make.left.equalTo(_memberView.mas_right).with.offset(10);
    }];
    
    [_commentGardeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_memberName);
        make.top.equalTo(_memberName.mas_bottom).with.offset(5);
        make.width.equalTo(@(120));
        make.height.equalTo(@(20));
    }];
}

- (void)createCommentGradeViewWithGrade:(NSString *)grade {
    if ([grade isEqualToString:@"0星"]) {
        _commentGardeView.image = [UIImage imageNamed:@"evalevel0"];
    } else if ([grade isEqualToString:@"1星"]) {
        _commentGardeView.image = [UIImage imageNamed:@"evalevel1"];
    } else if ([grade isEqualToString:@"2星"]) {
        _commentGardeView.image = [UIImage imageNamed:@"evalevel2"];
    } else if ([grade isEqualToString:@"3星"]) {
        _commentGardeView.image = [UIImage imageNamed:@"evalevel3"];
    } else if ([grade isEqualToString:@"4星"]) {
        _commentGardeView.image = [UIImage imageNamed:@"evalevel4"];
    } else if ([grade isEqualToString:@"5星"]) {
        _commentGardeView.image = [UIImage imageNamed:@"evalevel5"];
    }
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
        frame.size.height = labelSize.height*(lines+3)+160;
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
    NSArray *temp=[url componentsSeparatedByString:@";"];
    if (temp.count > 0) {
        for (int i = 0; i<temp.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,temp[i]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                imageView.image = image;
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

#pragma mark --- getters and setters ---
- (UIImageView *)memberView {
    if (!_memberView) {
        _memberView = [[UIImageView alloc] init];
        _memberView.layer.cornerRadius = 20;
    }
    return _memberView;
}

- (UILabel *)memberName {
    if (!_memberName) {
        _memberName = [[UILabel alloc] init];
        _memberName.font = [UIFont systemFontOfSize:12];
        [_memberName sizeToFit];
    }
    return _memberName;
}

- (UILabel *)commentContent {
    if (!_commentContent) {
        _commentContent = [[UILabel alloc] init];
        _commentContent.font = [UIFont systemFontOfSize:14];
    }
    return _commentContent;
}

- (UIImageView *)commentGardeView {
    if (!_commentGardeView) {
        _commentGardeView = [[UIImageView alloc] init];
    }
    return _commentGardeView;
}

@end
