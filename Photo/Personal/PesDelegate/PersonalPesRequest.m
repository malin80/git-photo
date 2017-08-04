//
//  PersonalPesRequest.m
//  Photo
//
//  Created by malin  on 2017/8/1.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "PersonalPesRequest.h"
#import "PesRequest.h"

@implementation PersonalPesRequest

+ (void)queryCollectGoodsInfoWithMemberId:(long)memberId withBlock:(void (^)(NSDictionary *response, NSString *error))finished {
    NSDictionary *dict = @{@"memberId":@(memberId)};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"CollectionInfoControl/queryCollectionInfo.do" dic:dict finished:finished];
}

@end
