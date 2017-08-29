//
//  FlowerPesRequest.m
//  Photo
//
//  Created by malin  on 2017/8/29.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "FlowerPesRequest.h"

@implementation FlowerPesRequest

+ (void)queryAllFlower:(void (^)(NSDictionary *, NSString *))finished {
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"FloricultureControl/queryFloriculture.do" dic:nil finished:finished];
}

@end
