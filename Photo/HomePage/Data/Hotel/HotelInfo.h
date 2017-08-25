//
//  HotelInfo.h
//  Photo
//
//  Created by malin  on 2017/8/25.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotelInfo : NSObject

@property (nonatomic, copy) NSString *hotelDesc;
@property (nonatomic, copy) NSString *hotelName;
@property (nonatomic, copy) NSString *hotelAddress;
@property (nonatomic, copy) NSString *hotelGrade;
@property (nonatomic, copy) NSString *hotelPhone;
@property (nonatomic, copy) NSString *hotelOrderDesc;
@property (nonatomic, copy) NSString *hotelPic;
@property (nonatomic, copy) NSString *hotelHeadImage;
@property (nonatomic, copy) NSString *hotelType;

@property (nonatomic, assign) long hotelId;
@property (nonatomic, assign) long maxPrice;
@property (nonatomic, assign) long minPrice;
@property (nonatomic, assign) long containCount;

@end
