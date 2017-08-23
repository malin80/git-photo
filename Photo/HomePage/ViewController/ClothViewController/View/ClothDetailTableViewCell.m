//
//  ClothDetailTableViewCell.m
//  Photo
//
//  Created by malin  on 2017/8/23.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "ClothDetailTableViewCell.h"

@implementation ClothDetailTableViewCell

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
    [self addSubview:self.priceLabel];
    [self addSubview:self.oldPriceLabel];
    [self addSubview:self.line];
    [self addSubview:self.icon1];
    [self addSubview:self.icon2];
    [self addSubview:self.titleView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.subTitle];
    [self addSubview:self.arrow];
    [self addSubview:self.paramLabel];
    [self addSubview:self.clothView];
}

- (void)setImmutableConstraints {
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).with.offset(10);
    }];
    
    [_oldPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceLabel);
        make.left.equalTo(_priceLabel.mas_right).with.offset(10);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_oldPriceLabel);
        make.left.equalTo(_oldPriceLabel);
        make.width.equalTo(_oldPriceLabel);
        make.height.equalTo(@(1));
    }];
    
    [_icon1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceLabel);
        make.left.equalTo(_oldPriceLabel.mas_right).with.offset(5);
    }];
    
    [_icon2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_icon1);
        make.left.equalTo(_icon1.mas_right).with.offset(5);
    }];
    
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.centerY.equalTo(self);
        make.height.equalTo(@(15));
        make.width.equalTo(@(15));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleView.mas_right).with.offset(10);
        make.centerY.equalTo(self);
    }];
    
    [_paramLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.centerY.equalTo(self);
        make.width.equalTo(@(ScreenWidth));
    }];
    
    [_clothView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(ScreenWidth));
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

-(void)setCommentContentText:(NSString*)text withCommentImageUrl:(NSString *)url {
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
    self.paramLabel.text = text;
    //设置label的最大行数
    self.paramLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:text];
    self.paramLabel.attributedText = attrStr;
    NSRange range = NSMakeRange(0, attrStr.length);
    NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];   // 获取该段attributedString的属性字典
    // 计算文本的大小
    CGSize labelSize = [self.paramLabel.text boundingRectWithSize:self.paramLabel.bounds.size // 用于计算文本绘制时占据的矩形块
                                                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                                           attributes:dic        // 文字的属性
                                                              context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    int lines = labelSize.width/ScreenWidth;
    
    self.paramLabel.frame = CGRectMake(20, 45, ScreenWidth-20, labelSize.height*(lines+3));
    self.paramLabel.numberOfLines = 2;
    frame.size.height = labelSize.height*(lines+3)+40;
    self.frame = frame;
}


#pragma mark --- getters and setters ---
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textColor  = [UIColor colorR:64 G:72 B:70 alpha:1];
        _priceLabel.font = [UIFont systemFontOfSize:14];
        _priceLabel.hidden = YES;
        [_priceLabel sizeToFit];
    }
    return _priceLabel;
}

- (UILabel *)oldPriceLabel {
    if (!_oldPriceLabel) {
        _oldPriceLabel = [[UILabel alloc] init];
        _oldPriceLabel.textColor = [UIColor colorR:176 G:176 B:176 alpha:1];
        _oldPriceLabel.font = [UIFont systemFontOfSize:14];
        _oldPriceLabel.hidden = YES;
        [_oldPriceLabel sizeToFit];
    }
    return _oldPriceLabel;
}

- (UILabel *)line {
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = [UIColor colorR:176 G:176 B:176 alpha:1];
        _line.hidden = YES;
    }
    return _line;
}

- (UILabel *)icon1 {
    if (!_icon1) {
        _icon1 = [[UILabel alloc] init];
        _icon1.text = @"惠";
        _icon1.font = [UIFont systemFontOfSize:14];
        _icon1.backgroundColor = [UIColor colorR:197 G:221 B:100 alpha:1];
        _icon1.hidden = YES;
    }
    return _icon1;
}

- (UILabel *)icon2 {
    if (!_icon2) {
        _icon2 = [[UILabel alloc] init];
        _icon2.text = @"租";
        _icon2.font = [UIFont systemFontOfSize:14];
        _icon2.backgroundColor = [UIColor colorR:117 G:176 B:235 alpha:1];
        _icon2.hidden = YES;
    }
    return _icon2;
}

- (UIImageView *)titleView {
    if (!_titleView) {
        _titleView = [[UIImageView alloc] init];
    }
    return _titleView;
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

- (UILabel *)paramLabel {
    if (!_paramLabel) {
        _paramLabel = [[UILabel alloc] init];
        _paramLabel.font = [UIFont systemFontOfSize:14];
        _paramLabel.textColor = [UIColor colorR:73 G:73 B:73 alpha:1];
        _paramLabel.hidden = YES;
    }
    return _paramLabel;
}

- (UIImageView *)clothView {
    if (!_clothView) {
        _clothView = [[UIImageView alloc] init];
    }
    return _clothView;
}

@end
