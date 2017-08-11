//
//  CameraManDetailTableViewCell.h
//  Photo
//
//  Created by malin  on 2017/8/9.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraManDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *memberView;
@property (nonatomic, strong) UILabel *memberName;
@property (nonatomic, strong) UILabel *commentContent;


//给用户介绍赋值并且实现自动换行
- (void)setCommentContentText:(NSString*)text withCommentImageUrl:(NSString *)url;

- (void)createCommentImageWithUrl:(NSString *)url;

@end
