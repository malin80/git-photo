//
//  HotelManager.m
//  Photo
//
//  Created by malin  on 2017/8/25.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "HotelManager.h"
#import "HotelPesRequest.h"
#import "HotelInfo.h"

@implementation HotelManager

SYNTHESIZE_SINGLETON_FOR_CLASS(HotelManager)

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hotelInfos = [NSMutableArray array];
    }
    return self;
}

- (void)queryAllHotel {
    [HotelPesRequest queryAllHotel:^(NSDictionary *responseObject, NSString *error) {
        if ([[responseObject objectForKey:@"errorCode"] unsignedLongValue] == 0) {
            [self.hotelInfos removeAllObjects];
            NSArray *array = [responseObject objectForKey:@"data"];
            for (NSDictionary *dict in array) {
                HotelInfo *info = [[HotelInfo alloc] init];
                info.hotelDesc = [dict objectForKey:@"hotelDescribe"];
                info.hotelAddress = [dict objectForKey:@"hotelAddress"];
                info.hotelName = [dict objectForKey:@"hotelName"];
                info.hotelGrade = [dict objectForKey:@"hotelGrade"];
                info.hotelPhone = [dict objectForKey:@"hotelPhone"];
                info.hotelOrderDesc = [dict objectForKey:@"hotelOrderForm"];
                info.hotelPic = [dict objectForKey:@"hotelPic"];
                info.hotelHeadImage = [dict objectForKey:@"hotelHeadImg"];
                info.maxPrice = [[dict objectForKey:@"hotelMaxPrice"] unsignedLongValue];
                info.minPrice = [[dict objectForKey:@"hotelMinPrice"] unsignedLongValue];
                info.containCount = [[dict objectForKey:@"hotelContainCount"] unsignedLongValue];
                info.hotelId = [[dict objectForKey:@"hotelId"] unsignedLongValue];
                NSDictionary *hotelType = [dict objectForKey:@"hotelType"];
                info.hotelType = [hotelType objectForKey:@"hotelTypeName"];
                [self.hotelInfos addObject:info];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"queryHotelSuccess" object:nil];
            });
        }
    }];
}

- (void)queryHotelWithId:(long)hotelId {
    [HotelPesRequest queryHotelWithId:hotelId withBlock:^(NSDictionary *responseObject, NSString *error) {
        if ([[responseObject objectForKey:@"errorCode"] unsignedLongValue] == 0) {
            NSDictionary *dict = [responseObject objectForKey:@"data"];
            self.hotelCommentList = [dict objectForKey:@"hotelCommentList"];
            self.hotelFoodMenus = [dict objectForKey:@"menuList"];
            self.hotelHalls = [dict objectForKey:@"banquetHallList"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"queryHotelDetailSuccess" object:nil];
            });
        }
    }];
}

@end
