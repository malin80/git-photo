//
//  StoreCollectionViewCell.h
//  Photo
//
//  Created by malin  on 2017/8/2.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *goodsName;
@property (nonatomic, strong) UILabel *goodsPrice;
@property (nonatomic, strong) UILabel *line;

@end
