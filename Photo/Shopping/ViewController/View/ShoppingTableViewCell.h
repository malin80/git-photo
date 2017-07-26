//
//  ShoppingTableViewCell.h
//  Photo
//
//  Created by malin  on 2017/7/25.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *selectedView;
@property (nonatomic, strong) UIImageView *goodsImage;
@property (nonatomic, strong) UILabel *goodsName;
@property (nonatomic, strong) UILabel *goodsParameter;
@property (nonatomic, strong) UILabel *goodsPrice;
@property (nonatomic, strong) UILabel *goodsCount;
@property (nonatomic, strong) UIButton *deleteButton;

@end
