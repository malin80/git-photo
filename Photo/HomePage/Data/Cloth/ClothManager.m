//
//  ClothManager.m
//  Photo
//
//  Created by malin  on 2017/8/23.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "ClothManager.h"
#import "ClothPesRequest.h"
#import "ClothInfo.h"
#import "StoreCommentInfo.h"

@implementation ClothManager

SYNTHESIZE_SINGLETON_FOR_CLASS(ClothManager)

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.clothTypes = [NSMutableArray array];
        self.cloths = [NSMutableArray array];
        self.commentInfos = [NSMutableArray array];
    }
    return self;
}

- (void)queryClothTypes {
    [ClothPesRequest queryClothType:^(NSDictionary *responseObject, NSString *error) {
        if ([[responseObject objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            if (![[responseObject objectForKey:@"data"] isKindOfClass:[NSString class]]) {
                [self.clothTypes removeAllObjects];
                NSArray *array = [responseObject objectForKey:@"data"];
                for (NSDictionary *dict in array) {
                    ClothInfo *info  = [[ClothInfo alloc] init];
                    info.clothTypeId = [[dict objectForKey:@"weddingDressTypeId"] unsignedLongValue];
                    info.clothTypeName = [dict objectForKey:@"weddingDressTypeName"];
                    [self.clothTypes addObject:info];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"queryClothTypesSuccess" object:nil];
                });
            }
        }
    }];
}

- (void)queryClothsWithTypeId:(long)typeId {
    [ClothPesRequest queryClothsWithTypeId:typeId withBlock:^(NSDictionary *responseObject, NSString *error) {
        if ([[responseObject objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            [self.cloths removeAllObjects];
            if (![[responseObject objectForKey:@"data"] isKindOfClass:[NSString class]]) {
                NSArray *array = [responseObject objectForKey:@"data"];
                for (NSDictionary *dict in array) {
                    ClothInfo *info = [[ClothInfo alloc] init];
                    info.clothName = [dict objectForKey:@"weddingDressShopName"];
                    info.clothParam = [dict objectForKey:@"weddingDressShopParam"];
                    info.clothSetType = [dict objectForKey:@"weddingDressShopSetType"];
                    info.clothDetailPic = [dict objectForKey:@"weddingDressShopDetail"];
                    info.clothPic = [dict objectForKey:@"weddingDressShopPic"];
                    info.clothShopCoupon = [dict objectForKey:@"weddingDressShopCoupon"];
                    info.clothId = [[dict objectForKey:@"weddingDressShopId"] unsignedLongValue];
                    info.clothOldPrice = [[dict objectForKey:@"weddingDressShopCostPrice"] unsignedLongValue];
                    info.clothPrice = [[dict objectForKey:@"weddingDressShopPreferentialPrice"] unsignedLongValue];
                    info.isHire = [[dict objectForKey:@"isHire"] unsignedLongValue];
                    [self.cloths addObject:info];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"queryClothsSuccess" object:nil];
                });
            }
        }
    }];
}

- (void)queryClothDetailWithClothId:(long)clothId {
    [ClothPesRequest queryClothDetailWithClothId:clothId withBlock:^(NSDictionary *responseObject, NSString *error) {
        if ([[responseObject objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            NSDictionary *dict = [responseObject objectForKey:@"data"];
            NSDictionary *shopDict = [dict objectForKey:@"shop"];
            self.clothShopInfo = [[ClothShopInfo alloc] init];
            self.clothShopInfo.shopName = [shopDict objectForKey:@"shopName"];
            self.clothShopInfo.shopPhone = [shopDict objectForKey:@"shopPhone"];
            self.clothShopInfo.shopAddress = [shopDict objectForKey:@"shopAddress"];
            self.clothShopInfo.shopDesc = [shopDict objectForKey:@"shopDescribe"];
            
            
            NSArray *array = [dict objectForKey:@"weddingDressShopCommentList"];
            for (NSDictionary *dict in array) {
                StoreCommentInfo *info = [[StoreCommentInfo alloc] init];
                info.commentText = [dict objectForKey:@"weddingDressShopCommentText"];
                info.commentImageUrl = [dict objectForKey:@"weddingDressShopCommentPic"];
                info.commentGrade = [dict objectForKey:@"weddingDressShopCommentGrade"];
                NSDictionary *memberDetail = [dict objectForKey:@"memberDetail"];
                info.commentName = [memberDetail objectForKey:@"pickName"];
                info.commentImage = [memberDetail objectForKey:@"memberPic"];
                [self.commentInfos addObject:info];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"queryClothDetailSuccess" object:nil];
            });
        }
    }];
}

- (void)buyClothWithToken:(NSString *)token withClothId:(long)clothId withClothCount:(long)count {
    [ClothPesRequest buyClothWithToken:token withClothId:clothId withClothCount:count withBlock:^(NSDictionary *responseObject, NSString *error) {
        
    }];
}

- (void)queryClothOrderWithToken:(NSString *)token {
    [ClothPesRequest queryClothOrderWithToken:token withBlock:^(NSDictionary *responseObject, NSString *error) {
        if ([[responseObject objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            
        }
    }];
}

@end
