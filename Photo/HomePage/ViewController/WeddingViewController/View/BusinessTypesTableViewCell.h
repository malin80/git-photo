//
//  BusinessTypesTableViewCell.h
//  Photo
//
//  Created by malin  on 2017/8/22.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessTypesTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UILabel *casePriceLabel;
@property (nonatomic, strong) UILabel *tagLabel;

@end
