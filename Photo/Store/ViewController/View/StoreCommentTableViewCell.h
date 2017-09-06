//
//  StoreCommentTableViewCell.h
//  Photo
//
//  Created by malin  on 2017/8/11.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StoreCommentTableViewCellDelegate <NSObject>

@optional
- (void)touchCommentImage:(NSArray *)imageUrl select:(int)index;

@end

@interface StoreCommentTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *memberView;
@property (nonatomic, strong) UILabel *memberName;
@property (nonatomic, strong) UILabel *commentContent;
@property (nonatomic, strong) NSArray *temp;

@property(nonatomic, weak)  id<StoreCommentTableViewCellDelegate> delegate;

//给用户介绍赋值并且实现自动换行
- (void)setCommentContentText:(NSString*)text withCommentImageUrl:(NSString *)url;

- (void)createCommentImageWithUrl:(NSString *)url;

@end
