//
//  ShoppingGoodsInfo.h
//  Photo
//
//  Created by malin  on 2017/8/4.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "GoodsInfo.h"

@interface ShoppingGoodsInfo : GoodsInfo

@property (nonatomic, assign) long goodsCartId;
@property (nonatomic, assign) long goodsCartCount;
@property (nonatomic, assign) long goodsCartPrice;
@property (nonatomic, assign) BOOL isSelected;

@end
