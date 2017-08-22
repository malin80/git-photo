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

@property (nonatomic, strong) NSMutableArray *storeComments;

@property (nonatomic, copy) NSString *Paydata;
@property (nonatomic, strong)NSDictionary *wxDic;

- (void)queryAllGoodsInfo;

- (void)queryGoodsClassify;

//收藏
- (void)collectGoodsWithMemberId:(long)memberId withGoodsId:(long)goodsId;

//加入购物车
- (void)addGoodsToShoppingWithGoodsCount:(NSString *)goodsCount withGoodParam:(NSString *)goodsParam withSafeCodeValue:(NSString *)value withGoodsId:(long)goodsId;

- (void)queryGoodsInfoWithGoodsType:(long)goodsType withSortName:(NSString *)sortName withSortOrder:(NSString *)sortOrder;

//立即购买
- (void)buyGoodsWithToken:(NSString *)token withMemberName:(NSString *)name withMemberPhone:(NSString *)phone withMemberAddress:(NSString *)address withGoodsId:(long)goodsId withGoodsPrice:(long)goodsPrice withGoodCount:(long)goodsCount withGoodsParam:(NSString *)goodsParam withCartIds:(NSString *)cartIds withIsCart:(long)isCart withCartCount:(long)cartCount withIndex:(int)index;


- (void)queryGoodsDetailInfoWithGoodsId:(long)goodsId;

- (void)payByAliWithToken:(NSString *)token withGoodsPayId:(NSString *)goodsPayId withOrderPayId:(NSString *)orderPayId;

@end
