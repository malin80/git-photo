//
//  FlowerCollectionViewCell.h
//  Photo
//
//  Created by malin  on 2017/8/29.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlowerCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *flowerView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *oldPriceLabel;

@end
