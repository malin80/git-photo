//
//  StoreManager.h
//  Photo
//
//  Created by malin  on 2017/8/2.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreManager : NSObject

DECLARE_SINGLETON_FOR_CLASS(StoreManager)

@property (nonatomic, strong) NSMutableArray *goodsInfoArray;

@property (nonatomic, strong) NSMutableArray *goodsClassifyArray;

- (void)queryAllGoodsInfo;

- (void)queryGoodsClassify;

//收藏
- (void)collectGoodsWithMemberId:(long)memberId withGoodsId:(long)goodsId;

//加入购物车
- (void)addGoodsToShoppingWithGoodsCount:(NSString *)goodsCount withGoodParam:(NSString *)goodsParam withSafeCodeValue:(NSString *)value withGoodsId:(long)goodsId;

//立即购买
- (void)buyGoods;

@end
