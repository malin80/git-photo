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

+ (void)buyGoodsWithToken:(NSString *)token withMemberName:(NSString *)name withMemberPhone:(NSString *)phone withMemberAddress:(NSString *)address withGoodsId:(long)goodsId withGoodsPrice:(long)goodsPrice withGoodCount:(long)goodsCount withGoodsParam:(NSString *)goodsParam withCartIds:(NSString *)cartIds withIsCart:(long)isCart withCartCount:(long)cartCount withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished;

+ (void)queryGoodsDetailInfoWithGoodsId:(long)goodsId withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished;

//支付宝支付接口
//AlipayControl/alipayTo.do(token,orderOfGoodsDetailIds,orderInfoId)
//--token 用户的安全码
//--orderOfGoodsDetailIds  订单详细id  多条用 ; 分隔  商品订单支付时必传
//--orderInfoId  预约订单id  预约订单支付时必传
//
//微信支付接口
//WxpayControl/WxpayTo.do(token,orderOfGoodsDetailIds,orderInfoId)
//--token 用户的安全码
//--orderOfGoodsDetailIds  订单详细id  多条用 ; 分隔  商品订单支付时必传
//--orderInfoId  预约订单id  预约订单支付时必传
+ (void)payByAliWithToken:(NSString *)token withGoodsPayId:(NSString *)goodsPayId withOrderPayId:(NSString *)orderPayId withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished;


+ (void)payByWechatWithToken:(NSString *)token withGoodsPayId:(NSString *)goodsPayId withOrderPayId:(NSString *)orderPayId withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished;

@end
