//
//  FlowerManager.m
//  Photo
//
//  Created by malin  on 2017/8/29.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "FlowerManager.h"
#import "FlowerPesRequest.h"
#import "FlowerInfo.h"

@implementation FlowerManager

SYNTHESIZE_SINGLETON_FOR_CLASS(FlowerManager)


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.flowerInfos = [NSMutableArray array];
    }
    return self;
}

- (void)queryAllFlower {
    [FlowerPesRequest queryAllFlower:^(NSDictionary *responseObject, NSString *error) {
        if ([[responseObject objectForKey:@"errorCode"] unsignedLongValue] == 0) {
            [self.flowerInfos removeAllObjects];
            NSArray *array = [responseObject objectForKey:@"data"];
            for (NSDictionary *dict in array) {
                FlowerInfo *info = [[FlowerInfo alloc] init];
                info.flowerContact = [dict objectForKey:@"floricultureContact"];
                info.flowerDesc = [dict objectForKey:@"floricultureIntroduce"];
                info.flowerName = [dict objectForKey:@"floricultureName"];
                info.flowerAddress = [dict objectForKey:@"floricultureAddress"];
                info.flowerPic = [dict objectForKey:@"floriculturePic"];
                info.flowerDetailPic = [dict objectForKey:@"floricultureDetail"];
                info.flowerId = [[dict objectForKey:@"floricultureId"] unsignedLongValue];
                info.flowerOldPrice = [[dict objectForKey:@"floricultureCostPrice"] unsignedLongValue];
                info.flowerPrice = [[dict objectForKey:@"floriculturePreferentialPrice"] unsignedLongValue];
                [self.flowerInfos addObject:info];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"queryFlowerSuccess" object:nil];
        }
    }];
}

@end
