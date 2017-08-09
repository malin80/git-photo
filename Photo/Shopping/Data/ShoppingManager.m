//
//  ShoppingManager.m
//  Photo
//
//  Created by malin  on 2017/8/4.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "ShoppingManager.h"
#import "ShoppingPesRequest.h"
#import "ShoppingGoodsInfo.h"

@implementation ShoppingManager

SYNTHESIZE_SINGLETON_FOR_CLASS(ShoppingManager)

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.shoppingGoodsInfos = [NSMutableArray array];
    }
    return self;
}

- (void)queryShoppingGoodsInfoWithSafeCodeValue:(NSString *)value {
    [ShoppingPesRequest queryShoppingGoodsInfoWithSafeCodeValue:value withBlock:^(NSDictionary *responseObject, NSString *error) {
        if ([[responseObject objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            if (![[responseObject objectForKey:@"data"] isKindOfClass:[NSString class]]) {
                NSArray *array = [responseObject objectForKey:@"data"];
                [self.shoppingGoodsInfos removeAllObjects];
                for (NSDictionary *dict in array) {
                    ShoppingGoodsInfo *info = [[ShoppingGoodsInfo alloc] init];
                    info.goodsCartId = [[dict objectForKey:@"cartId"] unsignedLongValue];
                    info.goodsCartCount = [[dict objectForKey:@"goodsCount"] unsignedLongValue];
                    info.goodsCartPrice = [[dict objectForKey:@"cartPrice"] unsignedLongValue];
                    NSDictionary *subDict = [dict objectForKey:@"goodsInfo"];
                    info.goodsName = [subDict objectForKey:@"goodsName"];
                    info.goodsDate = [subDict objectForKey:@"goodsDate"];
                    info.goodsId = [[subDict objectForKey:@"goodsId"] unsignedLongValue];
                    info.goodsPic = [subDict objectForKey:@"goodsPic"];
                    info.goodsDetailPic = [subDict objectForKey:@"goodsDetail"];
                    info.goodsPrice = [[subDict objectForKey:@"goodsPrice"] unsignedLongValue];
                    info.goodsCount = [[subDict objectForKey:@"goodsCount"] unsignedLongValue];
                    NSString *string = [dict objectForKey:@"goodsParameter"];
                    NSArray *temp=[string componentsSeparatedByString:@":"];
                    info.goodsParamValue = temp[1];
                    [self.shoppingGoodsInfos addObject:info];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"queryShoppingGoodsInfoSuccess" object:nil];
                });
            } else {
                //空了
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"queryShoppingGoodsInfoWithNoData" object:nil];
                });
            }
        }
    }];
}

- (void)deleteShoppingGoodsInfoWithCartId:(long)cartId withToken:(NSString *)token {
   [ShoppingPesRequest deleteShoppingGoodsInfoWithCartId:cartId withToken:token withBlock:^(NSDictionary *responseObject, NSString *error) {
           dispatch_async(dispatch_get_main_queue(), ^{
               [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteShoppingGoodsInfoSuccess" object:nil];
           });
   }];
}

@end
