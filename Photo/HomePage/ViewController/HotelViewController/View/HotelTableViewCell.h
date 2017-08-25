//
//  HotelTableViewCell.h
//  Photo
//
//  Created by malin  on 2017/8/25.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *titleView;
@property (nonatomic, strong) UIImageView *goldView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *contailLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *giftIcon;

@end
