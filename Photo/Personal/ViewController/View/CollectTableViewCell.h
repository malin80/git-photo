//
//  CollectTableViewCell.h
//  Photo
//
//  Created by malin  on 2017/7/25.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CollectTableViewCellDelegate <NSObject>

@optional
- (void)cancelColletGoodsInfo:(UIButton *)sender;
- (void)lookUpButtonClick:(UIButton *)sender;

@end

@interface CollectTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *goodsImage;
@property (nonatomic, strong) UILabel *goodsNamme;
@property (nonatomic, strong) UILabel *goodsSales;
@property (nonatomic, strong) UILabel *goodsPrice;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UIButton *lookUpButton;
@property (nonatomic, strong) UIButton *buyButton;
@property (nonatomic, strong) UIButton *cancelCollectButton;

@property(nonatomic, weak)  id<CollectTableViewCellDelegate> delegate;


@end
