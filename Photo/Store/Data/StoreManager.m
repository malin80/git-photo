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
    }
    return self;
}

- (void)queryAllGoodsInfo {
    [StorePesRequest queryAllGoodsInfo:^(NSDictionary *responseObject, NSString *error) {
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
        }
    }];
}

@end
