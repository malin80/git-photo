//
//  StorePesRequest.h
//  Photo
//
//  Created by malin  on 2017/8/2.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PesRequest.h"

@interface StorePesRequest : NSObject

+ (void)queryAllGoodsInfo:(void(^)(NSDictionary *responseObject,NSString *error))finished;

+ (void)queryGoodsClassify:(void(^)(NSDictionary *responseObject,NSString *error))finished;

+ (void)collectGoodsWithMemberId:(long)memberId withGoodsId:(long)goodsId withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished;

+ (void)addGoodsToShoppingWithGoodsCount:(NSString *)goodsCount withGoodParam:(NSString *)goodsParam withSafeCodeValue:(NSString *)value withGoodsId:(long)goodsId withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished;

+ (void)queryGoodsInfoWithGoodsType:(long)goodsType withSortName:(NSString *)sortName withSortOrder:(NSString *)sortOrder withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished;

//	OrderOfGoodsControl/saveOrderOfGoods.do(token,deliveryName,deliveryPhone,deliveryAddress,goodsId,goodsPrice,goodsCount,goodsParam,cartIds,isCart,cartCount)
//--deliveryName 收货人
//--deliveryPhone  联系方式
//--deliveryAddress  收货地址
//--goodsParam是用户选择的商品参数连接的字符串
//--cartIds 用户选择的购物车id连接的字符串 用;隔开  如:  1;2;3
//--isCart 用户提交订单的方式  必填  0:直接购买 1:通过购物车购买
//--cartCount  用户选择的购物车id的数量 通过购物车提交时必填
//
//--直接下单时 传memberId,deliveryName,deliveryPhone,deliveryAddress,goodsId,goodsPrice,goodsCount,goodsParam,isCart
//--购物车下单时传 memberId,deliveryName,deliveryPhone,deliveryAddress,cartIds,isCart,cartCount

+ (void)buyGoodsWithToken:(NSString *)token withMemberName:(NSString *)name withMemberPhone:(NSString *)phone withMemberAddress:(NSString *)address withGoodsId:(long)goodsId withGoodsPrice:(long)goodsPrice withGoodCount:(long)goodsCount withGoodsParam:(NSString *)goodsParam withCartIds:(NSString *)cartIds withIsCart:(long)isCart withCartCount:(long)cartCount withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished;

@end
