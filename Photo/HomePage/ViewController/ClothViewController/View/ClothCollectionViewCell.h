//
//  ClothCollectionViewCell.h
//  Photo
//
//  Created by malin  on 2017/8/23.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClothCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *clothName;
@property (nonatomic, strong) UILabel *clothPrice;
@property (nonatomic, strong) UILabel *clothOldPrice;
@property (nonatomic, strong) UILabel *line;
@property (nonatomic, strong) UILabel *icon1;
@property (nonatomic, strong) UILabel *icon2;

@end
