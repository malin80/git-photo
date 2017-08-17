//
//  WeddingPesRequest.m
//  Photo
//
//  Created by malin  on 2017/8/17.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "WeddingPesRequest.h"

@implementation WeddingPesRequest

+ (void)queryAllWeddingBusiness:(void (^)(NSDictionary *, NSString *))finished {
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"BusinessControl/queryBusiness.do" dic:nil finished:finished];
}

+ (void)queryWeddingBusinessWithId:(long)businessId withBlock:(void (^)(NSDictionary *, NSString *))finished {
    NSDictionary *dict = @{@"businessId":@(businessId)};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"BusinessControl/queryBusinessById.do" dic:dict finished:finished];
}

@end
