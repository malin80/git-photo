//
//  ShoppingBottomView.h
//  Photo
//
//  Created by malin  on 2017/7/25.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingGoodsInfo.h"

@protocol ShoppingBottomViewDelegate <NSObject>

@optional
- (void)changeSelectedArrayWith:(BOOL)allSelected;
- (void)buyButtonClick;

@end

@interface ShoppingBottomView : UIView

@property (nonatomic, strong) UIButton *selectedView;
@property (nonatomic, strong) UILabel *selectAll;
@property (nonatomic, strong) UILabel *total;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UIButton *buyButton;

@property (nonatomic, strong) ShoppingGoodsInfo *info;

@property(nonatomic, weak)  id<ShoppingBottomViewDelegate> delegate;


- (void)changeSelectViewIconWithSelected:(BOOL)selected;

@end
