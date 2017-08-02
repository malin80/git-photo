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

@end
