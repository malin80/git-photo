//
//  CarInfo.h
//  Photo
//
//  Created by malin  on 2017/8/28.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarInfo : NSObject

@property (nonatomic, copy) NSString *carPic;
@property (nonatomic, copy) NSString *carAddress;
@property (nonatomic, copy) NSString *carPhone;

@property (nonatomic, assign) long carId;

@end
