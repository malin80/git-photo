//
//  ClothShopInfo.h
//  Photo
//
//  Created by malin  on 2017/8/23.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClothShopInfo : NSObject

@property (nonatomic, copy) NSString *shopAddress;
@property (nonatomic, copy) NSString *shopPhone;
@property (nonatomic, copy) NSString *shopName;
@property (nonatomic, copy) NSString *shopDesc;

@property (nonatomic, assign) long shopId;
@property (nonatomic, assign) long shopTypeId;

@end
