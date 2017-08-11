//
//  GoodsInfo.h
//  Photo
//
//  Created by malin  on 2017/8/2.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsInfo : NSObject

@property (nonatomic, copy)     NSString    *goodsName;
@property (nonatomic, copy)     NSString    *goodsPic;
@property (nonatomic, copy)     NSString    *goodsDate;
@property (nonatomic, copy)     NSString    *goodsDetailPic;
@property (nonatomic, copy)     NSString    *goodsSlideUrl;
@property (nonatomic, copy)     NSString    *goodsParamKey;
@property (nonatomic, copy)     NSString    *goodsParamValue;
@property (nonatomic, assign)   long         goodsPrice;
@property (nonatomic, assign)   long         goodsId;
@property (nonatomic, assign)   long         goodsCount;                //已售
@property (nonatomic, assign)   long         goodsSlideId;
@property (nonatomic, strong)   NSMutableArray *goodsSlideUrls;

@property (nonatomic, strong)   NSString    *goodsTypeName;
@property (nonatomic, assign)   long         goodsTypeId;

@property (nonatomic, assign)   long         goodsOrderId;          //订单id
@property (nonatomic, copy)     NSString    *goodsOrderNum;
@property (nonatomic, copy)     NSString    *goodsOrderStatus;

@end
