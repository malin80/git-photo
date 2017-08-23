//
//  ClothInfo.h
//  Photo
//
//  Created by malin  on 2017/8/23.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClothInfo : NSObject

//type
@property (nonatomic, assign) long clothTypeId;
@property (nonatomic, copy) NSString *clothTypeName;

//detail
@property (nonatomic, copy) NSString *clothName;
@property (nonatomic, copy) NSString *clothParam;
@property (nonatomic, copy) NSString *clothSetType;
@property (nonatomic, copy) NSString *clothDetailPic;
@property (nonatomic, copy) NSString *clothPic;
@property (nonatomic, copy) NSString *clothShopCoupon;

@property (nonatomic, assign) long clothId;
@property (nonatomic, assign) long clothPrice;
@property (nonatomic, assign) long clothOldPrice;
@property (nonatomic, assign) BOOL isHire;

@end
