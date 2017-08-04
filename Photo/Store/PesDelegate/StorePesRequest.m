//
//  StorePesRequest.m
//  Photo
//
//  Created by malin  on 2017/8/2.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "StorePesRequest.h"

@implementation StorePesRequest

+ (void)queryAllGoodsInfo:(void(^)(NSDictionary *responseObject,NSString *error))finished {
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"GoodsInfoControl/queryGoodsInfo.do" dic:nil finished:finished];
}

+ (void)queryGoodsClassify:(void(^)(NSDictionary *responseObject,NSString *error))finished {
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"GoodsTypeControl/queryGoodsType.do" dic:nil finished:finished];
}

+ (void)collectGoodsWithMemberId:(long)memberId withGoodsId:(long)goodsId withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished {
    NSDictionary *dict = @{@"memberId":@(memberId),@"goodsId":@(goodsId)};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"CollectionInfoControl/saveCollectionInfo.do" dic:dict finished:finished];
}

+ (void)addGoodsToShoppingWithGoodsCount:(NSString *)goodsCount withGoodParam:(NSString *)goodsParam withSafeCodeValue:(NSString *)value withGoodsId:(long)goodsId withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished {
    NSDictionary *dict = @{@"goodsCount":goodsCount,@"goodsParam":goodsParam,@"token":value,@"goodsId":@(goodsId)};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"CartInfoControl/saveCartInfo.do" dic:dict finished:finished];
}


@end
