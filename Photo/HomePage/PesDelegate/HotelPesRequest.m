//
//  HotelPesRequest.m
//  Photo
//
//  Created by malin  on 2017/8/25.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "HotelPesRequest.h"

@implementation HotelPesRequest

+ (void)queryAllHotel:(void (^)(NSDictionary *, NSString *))finished {
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"HotelControl/queryAllHotel.do" dic:nil finished:finished];
}

+ (void)queryHotelWithId:(long)hotelId withBlock:(void (^)(NSDictionary *, NSString *))finished {
    NSDictionary *dict = @{@"hotelId":@(hotelId)};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"HotelControl/queryHotelById.do" dic:dict finished:finished];
}

@end
