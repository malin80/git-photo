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
        self.businessCases = [NSMutableArray array];
        self.businessTypeDetail = [NSMutableArray array];
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
                [self.businessCases removeAllObjects];
                [self.businessTypeDetail removeAllObjects];
                WeddingBusinessInfo *info = [[WeddingBusinessInfo alloc] init];
                NSDictionary *dict = [responseObject objectForKey:@"data"];
                self.businessComments = [dict objectForKey:@"businessCommentList"];
                self.businessTypes = [dict objectForKey:@"businessSetList"];
                info.businessName = [dict objectForKey:@"businessName"];
                self.businessLatitude = [[dict objectForKey:@"businessLatitude"] floatValue];
                self.businessLongitude = [[dict objectForKey:@"businessLongitude"] floatValue];
                for (NSDictionary *cases in self.businessTypes) {
                    NSArray *array = [cases objectForKey:@"businessCaseList"];
                    info.businessTypeName = [cases objectForKey:@"businessSetName"];
                    info.businessTypeStyle = [cases objectForKey:@"businessSetStyle"];
                    info.businessTypeSoldNumber = [[cases objectForKey:@"businessSetSoldNumber"] unsignedLongValue];
                    for (NSDictionary *dict in array) {
                        info.businessCaseId = [[dict objectForKey:@"businessCaseId"] unsignedLongValue];
                        info.businessCasePrice = [[dict objectForKey:@"businessCaseCurrentRate"] unsignedLongValue];
                        info.businessCasePic = [dict objectForKey:@"businessCasePic"];
                        info.businessTypeId = [[dict objectForKey:@"businessSetId"] unsignedLongValue];
                        info.businessCaseBrowser = [[dict objectForKey:@"businessCaseBrowser"] unsignedLongValue];
                        [self.businessCases addObject:info];
                    }
                    NSArray *typeDetail = [cases objectForKey:@"businessSetDetailList"];
                    for (NSDictionary *detailDict in typeDetail) {
                        WeddingBusinessInfo *info = [[WeddingBusinessInfo alloc] init];
                        info.businessTypeDetailDes = [detailDict objectForKey:@"businessSetDetailDescribe"];
                        info.businessTypeDetailName = [detailDict objectForKey:@"businessSetDetailName"];
                        info.businessTypeDetailPic = [detailDict objectForKey:@"businessSetDetailIcon"];
                        [self.businessTypeDetail addObject:info];
                    }
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"queryWeddingBusinessWithIdSuceess" object:nil];
            });
        }
    }];
}


@end
