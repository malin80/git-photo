//
//  CeremonyPesRequest.m
//  Photo
//
//  Created by malin  on 2017/8/30.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "CeremonyPesRequest.h"

@implementation CeremonyPesRequest

+ (void)queryAllCeremony:(void (^)(NSDictionary *, NSString *))finished {
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"EmceeControl/queryEmcee.do" dic:nil finished:finished];
}

+ (void)queryCeremonyDetailWithId:(long)ceremonyId withBlock:(void (^)(NSDictionary *, NSString *))finished {
    NSDictionary *dict = @{@"emceeId":@(ceremonyId)};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"EmceeControl/queryEmceeById.do" dic:dict finished:finished];
}

@end
