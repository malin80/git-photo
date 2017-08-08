//
//  StoreManager.m
//  Photo
//
//  Created by malin  on 2017/8/2.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "StoreManager.h"
#import "StorePesRequest.h"
#import "GoodsInfo.h"

@interface StoreManager ()

@end

@implementation StoreManager

SYNTHESIZE_SINGLETON_FOR_CLASS(StoreManager)

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.goodsInfoArray = [NSMutableArray array];
        self.goodsClassifyArray = [NSMutableArray array];
    }
    return self;
}

- (void)queryAllGoodsInfo {
    [StorePesRequest queryAllGoodsInfo:^(NSDictionary *responseObject, NSString *error) {
        if ([[responseObject objectForKey:@"errorCode"] unsignedLongValue] == 0) {
            NSArray *dataArray = [responseObject objectForKey:@"data"];
            for (NSDictionary *dict in dataArray) {
                GoodsInfo *info = [[GoodsInfo alloc] init];
                info.goodsSlideUrls = [NSMutableArray array];
                NSArray *goodsParamList = [dict objectForKey:@"goodsParamList"];
                for (NSDictionary *dict in goodsParamList) {
                    info.goodsParamKey = [dict objectForKey:@"paramKey"];
                    info.goodsParamValue = [dict objectForKey:@"paramValue"];
                }
                NSArray *goodsSlideList = [dict objectForKey:@"goodsSlideList"];
                for (NSDictionary *dict in goodsSlideList) {
                    info.goodsSlideId = [[dict objectForKey:@"goodsSlideId"] unsignedLongValue];
                    info.goodsSlideUrl = [dict objectForKey:@"goodsSlideUrl"];
                    [info.goodsSlideUrls addObject:info.goodsSlideUrl];
                }
                info.goodsName = [dict objectForKey:@"goodsName"];
                info.goodsPrice = [[dict objectForKey:@"goodsPrice"] unsignedLongValue];
                info.goodsPic = [dict objectForKey:@"goodsPic"];
                info.goodsId = [[dict objectForKey:@"goodsId"] unsignedLongValue];
                info.goodsCount = [[dict objectForKey:@"goodsCount"] unsignedLongValue];
                info.goodsDetailPic = [dict objectForKey:@"goodsDetail"];
                info.goodsDate = [dict objectForKey:@"goodsDate"];
                [_goodsInfoArray addObject:info];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"queryGoodsInfoWithTypeSuccess" object:nil];
                });
            }
        }
    }];
}

- (void)queryGoodsClassify {
    [StorePesRequest queryGoodsClassify:^(NSDictionary *responseObject, NSString *error) {
        if ([[responseObject objectForKey:@"errorCode"] unsignedLongValue] == 0) {
            NSArray *array = [responseObject objectForKey:@"data"];
            for (NSDictionary *dict in array) {
                GoodsInfo *info = [[GoodsInfo alloc] init];
                info.goodsTypeName = [dict objectForKey:@"goodsTypeName"];
                info.goodsTypeId = [[dict objectForKey:@"goodsTypeId"] unsignedLongValue];
                [_goodsClassifyArray addObject:info];
            }
        }
    }];
}

- (void)collectGoodsWithMemberId:(long)memberId withGoodsId:(long)goodsId {
    [StorePesRequest collectGoodsWithMemberId:memberId withGoodsId:goodsId withBlock:^(NSDictionary *responseObject, NSString *error) {
        
    }];
}

- (void)addGoodsToShoppingWithGoodsCount:(NSString *)goodsCount withGoodParam:(NSString *)goodsParam withSafeCodeValue:(NSString *)value withGoodsId:(long)goodsId {
    [StorePesRequest addGoodsToShoppingWithGoodsCount:goodsCount withGoodParam:goodsParam withSafeCodeValue:value withGoodsId:goodsId withBlock:^(NSDictionary *responseObject, NSString *error) {
        
    }];
}

- (void)queryGoodsInfoWithGoodsType:(long)goodsType withSortName:(NSString *)sortName withSortOrder:(NSString *)sortOrder {
    [StorePesRequest queryGoodsInfoWithGoodsType:goodsType withSortName:sortName withSortOrder:sortOrder withBlock:^(NSDictionary *responseObject, NSString *error) {
        if ([[responseObject objectForKey:@"errorCode"] unsignedLongValue] == 0) {
            if (![[responseObject objectForKey:@"data"] isKindOfClass:[NSString class]]) {
                [_goodsInfoArray removeAllObjects];
                NSArray *dataArray = [responseObject objectForKey:@"data"];
                for (NSDictionary *dict in dataArray) {
                    GoodsInfo *info = [[GoodsInfo alloc] init];
                    info.goodsSlideUrls = [NSMutableArray array];
                    NSArray *goodsParamList = [dict objectForKey:@"goodsParamList"];
                    for (NSDictionary *dict in goodsParamList) {
                        info.goodsParamKey = [dict objectForKey:@"paramKey"];
                        info.goodsParamValue = [dict objectForKey:@"paramValue"];
                    }
                    NSArray *goodsSlideList = [dict objectForKey:@"goodsSlideList"];
                    for (NSDictionary *dict in goodsSlideList) {
                        info.goodsSlideId = [[dict objectForKey:@"goodsSlideId"] unsignedLongValue];
                        info.goodsSlideUrl = [dict objectForKey:@"goodsSlideUrl"];
                        [info.goodsSlideUrls addObject:info.goodsSlideUrl];
                    }
                    info.goodsName = [dict objectForKey:@"goodsName"];
                    info.goodsPrice = [[dict objectForKey:@"goodsPrice"] unsignedLongValue];
                    info.goodsPic = [dict objectForKey:@"goodsPic"];
                    info.goodsId = [[dict objectForKey:@"goodsId"] unsignedLongValue];
                    info.goodsCount = [[dict objectForKey:@"goodsCount"] unsignedLongValue];
                    info.goodsDetailPic = [dict objectForKey:@"goodsDetail"];
                    info.goodsDate = [dict objectForKey:@"goodsDate"];
                    [_goodsInfoArray addObject:info];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"queryGoodsInfoWithTypeSuccess" object:nil];
                    });
                }
            }
        }
    }];
}

@end
