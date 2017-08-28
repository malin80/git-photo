//
//  CarManager.m
//  Photo
//
//  Created by malin  on 2017/8/28.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "CarManager.h"
#import "CarPesRequest.h"
#import "CarInfo.h"

@implementation CarManager

SYNTHESIZE_SINGLETON_FOR_CLASS(CarManager)


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.carInfos = [NSMutableArray array];
    }
    return self;
}

- (void)queryAllCar {
    [CarPesRequest queryAllCar:^(NSDictionary *responseObject, NSString *error) {
        if ([[responseObject objectForKey:@"errorCode"] unsignedLongValue] == 0) {
            [self.carInfos removeAllObjects];
            NSArray *array = [responseObject objectForKey:@"data"];
            for (NSDictionary *dict in array) {
                CarInfo *info = [[CarInfo alloc] init];
                info.carAddress = [dict objectForKey:@"marryCarAddress"];
                info.carPhone = [dict objectForKey:@"marryCarPhone"];
                info.carPic = [dict objectForKey:@"marryCarPic"];
                info.carId = [[dict objectForKey:@"marryCarId"] unsignedLongValue];
                [self.carInfos addObject:info];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"queryCarssSuccess" object:nil];
            });
        }
    }];
}

@end
