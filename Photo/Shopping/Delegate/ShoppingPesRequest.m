//
//  ShoppingPesRequest.m
//  Photo
//
//  Created by malin  on 2017/8/3.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "ShoppingPesRequest.h"

@implementation ShoppingPesRequest

+ (void)queryShoppingGoodsInfoWithSafeCodeValue:(NSString *)safeCodeValue withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished {
    NSDictionary *dict = @{@"token":safeCodeValue};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"CartInfoControl/queryCartInfo.do" dic:dict finished:finished];
}

+ (void)deleteShoppingGoodsInfoWithCartId:(long)cartId withToken:(NSString *)token withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished {
    NSDictionary *dict = @{@"cartId":@(cartId), @"token":token};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"CartInfoControl/deleteCartInfo.do" dic:dict finished:finished];
}

@end
