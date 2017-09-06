//
//  ClothCommentTableViewCell.h
//  Photo
//
//  Created by malin  on 2017/8/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClothCommentTableViewCellDelegate <NSObject>

@optional
- (void)touchCommentImage:(NSArray *)imageUrl select:(int)index;

@end

@interface ClothCommentTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *memberView;
@property (nonatomic, strong) UILabel *memberName;
@property (nonatomic, strong) UILabel *commentContent;
@property (nonatomic, strong) UIImageView *commentGardeView;
@property (nonatomic, strong) NSArray *temp;

@property(nonatomic, weak)  id<ClothCommentTableViewCellDelegate> delegate;


//给用户介绍赋值并且实现自动换行
- (void)setCommentContentText:(NSString*)text withCommentImageUrl:(NSString *)url;

- (void)createCommentImageWithUrl:(NSString *)url;

- (void)createCommentGradeViewWithGrade:(NSString *)grade;

@end
