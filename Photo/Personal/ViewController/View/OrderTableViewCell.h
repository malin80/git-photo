//
//  OrderTableViewCell.h
//  Photo
//
//  Created by malin  on 2017/7/31.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *goodsImage;
@property (nonatomic, strong) UILabel *goodsNamme;
@property (nonatomic, strong) UILabel *goodsParameter;
@property (nonatomic, strong) UILabel *goodsNumber;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *goodsCount;
@property (nonatomic, strong) UILabel *goodsPrice;
@property (nonatomic, strong) UILabel *goodsState;

@end
