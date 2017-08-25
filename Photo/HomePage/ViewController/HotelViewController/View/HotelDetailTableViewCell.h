//
//  HotelDetailTableViewCell.h
//  Photo
//
//  Created by malin  on 2017/8/25.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *giftIcon;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrow;

@end


@interface HotelDetailSecondTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *titleIcon;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrow;
@property (nonatomic, strong) UILabel *subTitle;

@end

@interface HotelDetailThirdTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *line;
@property (nonatomic, strong) UIImageView *hallImageView;
@property (nonatomic, strong) UILabel *hallNameLabel;
@property (nonatomic, strong) UILabel *hallContainLabel;
@property (nonatomic, strong) UILabel *hallHeight;

@end

@interface HotelDetailFourthTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrow;
@property (nonatomic, strong) UILabel *subTitle;

@end

@interface HotelDetailFifthTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *memberView;
@property (nonatomic, strong) UILabel *memberName;
@property (nonatomic, strong) UILabel *commentContent;
@property (nonatomic, strong) UIImageView *commentGardeView;

//给用户介绍赋值并且实现自动换行
- (void)setCommentContentText:(NSString*)text withCommentImageUrl:(NSString *)url;

- (void)createCommentImageWithUrl:(NSString *)url;

- (void)createCommentGradeViewWithGrade:(NSString *)grade;

@end
