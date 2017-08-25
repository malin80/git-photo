//
//  HotelManager.h
//  Photo
//
//  Created by malin  on 2017/8/25.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotelManager : NSObject

DECLARE_SINGLETON_FOR_CLASS(HotelManager)

@property (nonatomic, strong) NSMutableArray *hotelInfos;
@property (nonatomic, strong) NSArray *hotelCommentList;
@property (nonatomic, strong) NSArray *hotelFoodMenus;
@property (nonatomic, strong) NSArray *hotelHalls;

- (void)queryAllHotel;

- (void)queryHotelWithId:(long)hotelId;

@end
