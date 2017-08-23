//
//  ClothDetailTableViewCell.h
//  Photo
//
//  Created by malin  on 2017/8/23.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClothDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *oldPriceLabel;
@property (nonatomic, strong) UILabel *line;
@property (nonatomic, strong) UILabel *icon1;
@property (nonatomic, strong) UILabel *icon2;
@property (nonatomic, strong) UIImageView *titleView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitle;
@property (nonatomic, strong) UIImageView *arrow;
@property (nonatomic, strong) UILabel *paramLabel;
@property (nonatomic, strong) UIImageView *clothView;

- (void)setCommentContentText:(NSString*)text withCommentImageUrl:(NSString *)url;

@end
