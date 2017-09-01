//
//  CeremonyManager.m
//  Photo
//
//  Created by malin  on 2017/8/30.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "CeremonyManager.h"
#import "CeremonyPesRequest.h"
#import "CeremonyWorksInfo.h"

@implementation CeremonyManager

SYNTHESIZE_SINGLETON_FOR_CLASS(CeremonyManager)


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.ceremonyManInfos = [NSMutableArray array];
        self.ceremonyWomenInfos = [NSMutableArray array];
        self.ceremonyWorkInfos = [NSMutableArray array];
        self.ceremonyInfo = [[CeremonyInfo alloc] init];
    }
    return self;
}

- (void)queryAllCeremony {
    [CeremonyPesRequest queryAllCeremony:^(NSDictionary *responseObject, NSString *error) {
        if ([[responseObject objectForKey:@"errorCode"] unsignedLongValue] == 0) {
            [self.ceremonyManInfos removeAllObjects];
            [self.ceremonyWomenInfos removeAllObjects];
            NSArray *array = [responseObject objectForKey:@"data"];
            for (NSDictionary *dict in array) {
                CeremonyInfo *info = [[CeremonyInfo alloc] init];
                info.ceremonyName = [dict objectForKey:@"emceeName"];
                info.ceremonySex = [dict objectForKey:@"emceeSex"];
                info.ceremonyPic = [dict objectForKey:@"emceeHeadImg"];
                info.ceremonyPhone = [dict objectForKey:@"emceePhone"];
                info.ceremonySigh = [dict objectForKey:@"emceeSign"];
                info.ceremonySynopsis = [dict objectForKey:@"emceeSynopsis"];
                info.ceremonyId = [[dict objectForKey:@"emceeId"] unsignedLongValue];
                if ([info.ceremonySex isEqualToString:@"男"]) {
                    [self.ceremonyManInfos addObject:info];
                } else {
                    [self.ceremonyWomenInfos addObject:info];
                }
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"queryAllCeremonySuccess" object:nil];
        }
    }];
}

- (void)queryCeremonyDetailWithId:(long)ceremonyId {
    [CeremonyPesRequest queryCeremonyDetailWithId:ceremonyId withBlock:^(NSDictionary *responseObject, NSString *error) {
        if ([[responseObject objectForKey:@"errorCode"] unsignedLongValue] == 0) {
            [self.ceremonyWorkInfos removeAllObjects];
            NSDictionary *dict = [responseObject objectForKey:@"data"];
            self.ceremonyInfo.ceremonySynopsis = [dict objectForKey:@"emceeSynopsis"];
            NSArray *array = [dict objectForKey:@"emceeWorksList"];
            for (NSDictionary *dict in array) {
                CeremonyWorksInfo *info = [[CeremonyWorksInfo alloc] init];
                info.worksName = [dict objectForKey:@"emceeWorksName"];
                info.worksImage = [dict objectForKey:@"emceeWorksScreenshot"];
                info.worksVideo = [dict objectForKey:@"emceeWorksVideo"];
                [self.ceremonyWorkInfos addObject:info];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"queryCeremonyDetailSuccess" object:nil];
        }
    }];
}

@end
