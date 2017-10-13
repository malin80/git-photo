//
//  BusinessCommentTableViewCell.h
//  Photo
//
//  Created by malin  on 2017/8/17.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BusinessCommentTableViewCellDelegate <NSObject>

@optional
- (void)touchCommentImage:(NSArray *)imageUrl select:(int)index;

@end

@interface BusinessCommentTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *memberView;
@property (nonatomic, strong) UILabel *memberName;
@property (nonatomic, strong) UIImageView *commentGardeView;
@property (nonatomic, strong) UILabel *commentContent;
@property (nonatomic, strong) NSArray *temp;

@property(nonatomic, weak)  id<BusinessCommentTableViewCellDelegate> delegate;

//给用户介绍赋值并且实现自动换行
- (void)setCommentContentText:(NSString*)text withCommentImageUrl:(NSString *)url;

- (void)createCommentImageWithUrl:(NSString *)url;

- (void)createCommentGradeViewWithGrade:(NSString *)grade;

@end
