//
//  HotelPesRequest.h
//  Photo
//
//  Created by malin  on 2017/8/25.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PesRequest.h"

@interface HotelPesRequest : NSObject

+ (void)queryAllHotel:(void(^)(NSDictionary *responseObject,NSString *error))finished;

+ (void)queryHotelWithId:(long)hotelId withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished;

@end
