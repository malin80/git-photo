//
//  WeddingManager.m
//  Photo
//
//  Created by malin  on 2017/8/17.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "WeddingManager.h"
#import "WeddingPesRequest.h"
#import "WeddingBusinessInfo.h"

@implementation WeddingManager

SYNTHESIZE_SINGLETON_FOR_CLASS(WeddingManager)


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bussinessInfos = [NSMutableArray array];
    }
    return self;
}

- (void)queryAllWeddingBusiness {
    [WeddingPesRequest queryAllWeddingBusiness:^(NSDictionary *responseObject, NSString *error) {
        if ([[responseObject objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            [self.bussinessInfos removeAllObjects];
            if (![[responseObject objectForKey:@"data"] isKindOfClass:[NSString class]]) {
                NSArray *array = [responseObject objectForKey:@"data"];
                for (NSDictionary *dict in array) {
                    WeddingBusinessInfo *info = [[WeddingBusinessInfo alloc] init];
                    info.businessName = [dict objectForKey:@"businessName"];
                    info.businessPic = [dict objectForKey:@"businessHeadImg"];
                    info.businessPrice = [[dict objectForKey:@"businessMinPrice"] unsignedLongValue];
                    info.businessTypeCount = [[dict objectForKey:@"businessSetCount"] unsignedLongValue];
                    info.businessCaseCount = [[dict objectForKey:@"businessCaseCount"] unsignedLongValue];
                    info.businessCommentCount = [[dict objectForKey:@"businessCommentCount"] unsignedLongValue];
                    info.businessSubText1 = [dict objectForKey:@"businessCoupon"];
                    info.businessSubText2 = [dict objectForKey:@"businessOrderForm"];
                    info.businessScrollPic = [dict objectForKey:@"businessPic"];
                    info.businessIntroduction = [dict objectForKey:@"businessLabel"];
                    info.businessPhone = [dict objectForKey:@"businessPhone"];
                    info.businessAddress = [dict objectForKey:@"businessAddress"];
                    info.businessId = [[dict objectForKey:@"businessId"] unsignedLongValue];
                    [self.bussinessInfos addObject:info];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"queryAllBusinessSuceess" object:nil];
            });
        }
    }];
}

- (void)queryWeddingBusinessWithId:(long)businessId {
    [WeddingPesRequest queryWeddingBusinessWithId:businessId withBlock:^(NSDictionary *responseObject, NSString *error) {
        if ([[responseObject objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            if (![[responseObject objectForKey:@"data"] isKindOfClass:[NSString class]]) {
                NSDictionary *dict = [responseObject objectForKey:@"data"];
                self.businessComments = [dict objectForKey:@"businessCommentList"];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"queryWeddingBusinessWithIdSuceess" object:nil];
            });
        }
    }];
}


@end
