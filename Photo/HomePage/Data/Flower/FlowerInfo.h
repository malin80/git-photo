//
//  FlowerInfo.h
//  Photo
//
//  Created by malin  on 2017/8/29.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlowerInfo : NSObject

@property (nonatomic, copy) NSString *flowerContact;
@property (nonatomic, copy) NSString *flowerDesc;
@property (nonatomic, copy) NSString *flowerName;
@property (nonatomic, copy) NSString *flowerAddress;
@property (nonatomic, copy) NSString *flowerPic;
@property (nonatomic, copy) NSString *flowerDetailPic;

@property (nonatomic, assign) long flowerId;
@property (nonatomic, assign) long flowerOldPrice;
@property (nonatomic, assign) long flowerPrice;

@end
