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

@end
