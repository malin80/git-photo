//
//  ClothPesRequest.m
//  Photo
//
//  Created by malin  on 2017/8/23.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "ClothPesRequest.h"

@implementation ClothPesRequest

+ (void)queryClothType:(void (^)(NSDictionary *, NSString *))finished {
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"WeddingDressTypeControl/queryAllWeddingDressType.do" dic:nil finished:finished];
}

+ (void)queryClothsWithTypeId:(long)typeId withBlock:(void (^)(NSDictionary *, NSString *))finished {
    NSDictionary *dict = @{@"WeddingDressTypeId":@(typeId)};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"WeddingDressShopControl/queryWeddingDressShopByType.do" dic:dict finished:finished];
}

+ (void)queryClothDetailWithClothId:(long)clothId withBlock:(void (^)(NSDictionary *, NSString *))finished {
    NSDictionary *dict = @{@"WeddingDressShopId":@(clothId)};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"WeddingDressShopControl/queryWeddingDressShopById.do" dic:dict finished:finished];
}

+ (void)buyClothWithToken:(NSString *)token withClothId:(long)clothId withClothCount:(long)count withBlock:(void (^)(NSDictionary *, NSString *))finished {
    NSDictionary *dict = @{@"token":token, @"WeddingDressShopId":@(clothId), @"WeddingDressShopCount":@(count)};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"WeddingDressShopOrderControl/saveWeddingDressShopOrder.do" dic:dict finished:finished];
}

+ (void)queryClothOrderWithToken:(NSString *)token withBlock:(void (^)(NSDictionary *, NSString *))finished {
    NSDictionary *dict = @{@"token":token};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"WeddingDressShopOrderControl/queryWeddingDressShopOrder.do" dic:dict finished:finished];
}

@end
