//
//  CarPesRequest.m
//  Photo
//
//  Created by malin  on 2017/8/28.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "CarPesRequest.h"

@implementation CarPesRequest

+ (void)queryAllCar:(void (^)(NSDictionary *, NSString *))finished {
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"MarryCarControl/queryAllMarryCar.do" dic:nil finished:finished];
}

@end
