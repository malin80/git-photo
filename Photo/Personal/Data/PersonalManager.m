//
//  PersonalManager.m
//  Photo
//
//  Created by malin  on 2017/8/4.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "PersonalManager.h"
#import "PersonalPesRequest.h"
#import "LoginManager.h"
#import "CollectGoodsInfo.h"
#import "AddressInfo.h"
#import "CameraManInfo.h"

@implementation PersonalManager
SYNTHESIZE_SINGLETON_FOR_CLASS(PersonalManager)

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.collectGoodsInfos = [NSMutableArray array];
        self.addressInfos = [NSMutableArray array];
        self.normalAddressInfo = [[AddressInfo alloc] init];
        self.orderGoodsInfos = [NSMutableArray array];
        self.cameraManOrderInfos = [NSMutableArray array];
    }
    return self;
}

- (void)updateMemberInfoWithNickName:(NSString *)nickName
                      withMemberName:(NSString *)memberName
                       withMemberSex:(NSString *)memberSex
                     withMemberMarry:(NSString *)memberMarry
                  withMemberBirthday:(NSString *)memberBirthday
                           withToken:(NSString *)token {
    [PersonalPesRequest updateMemberInfoWithNickName:nickName withMemberName:memberName withMemberSex:memberSex withMemberMarry:memberMarry withMemberBirthday:memberBirthday withToken:token withBlock:^(NSDictionary *response, NSString *error) {
        if ([[response objectForKey:@"errorCode"] unsignedLongValue] == 0) {
            GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.memberName = memberName;
            [[NSUserDefaults standardUserDefaults] setObject:memberName forKey:@"memberName"];
            GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.memberNickName= nickName;
            [[NSUserDefaults standardUserDefaults] setObject:nickName forKey:@"memberNickName"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateMemberInfoSuccess" object:nil];
        }
    }];
}

- (void)updatePasswordWithToke:(NSString *)token withOldCode:(NSString *)oldCode withNewCode:(NSString *)newCode wihhUpdateType:(int)type {
    [PersonalPesRequest updatePasswordWithToke:token withOldCode:oldCode withNewCode:newCode wihhUpdateType:type withBlock:^(NSDictionary *response, NSString *error) {
        if ([[response objectForKey:@"errorCode"] unsignedLongValue] == 0) {
            GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.memberPwd = newCode;
            [[NSUserDefaults standardUserDefaults] setObject:newCode forKey:@"memberPwd"];
        }
    }];
}

- (void)queryCollectGoodsInfo {
    [PersonalPesRequest queryCollectGoodsInfoWithMemberId:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.memberId withBlock:^(NSDictionary *response, NSString *error) {
        if ([[response objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            if (![[response objectForKey:@"data"] isKindOfClass:[NSString class]]) {
                [self.collectGoodsInfos removeAllObjects];
                NSArray *array = [response objectForKey:@"data"];
                for (NSDictionary *dict in array) {
                    CollectGoodsInfo *info = [[CollectGoodsInfo alloc] init];
                    info.colletDate = [dict objectForKey:@"collectionDate"];
                    info.collectId = [[dict objectForKey:@"collectionId"] unsignedLongValue];
                    NSDictionary *subDict = [dict objectForKey:@"goodsInfo"];
                    info.goodsName = [subDict objectForKey:@"goodsName"];
                    info.goodsDate = [subDict objectForKey:@"goodsDate"];
                    info.goodsId = [[subDict objectForKey:@"goodsId"] unsignedLongValue];
                    info.goodsPic = [subDict objectForKey:@"goodsPic"];
                    info.goodsDetailPic = [subDict objectForKey:@"goodsDetail"];
                    info.goodsPrice = [[subDict objectForKey:@"goodsPrice"] unsignedLongValue];
                    info.goodsCount = [[subDict objectForKey:@"goodsCount"] unsignedLongValue];
                    [self.collectGoodsInfos addObject:info];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"queryCollectGoodsInfoSuccess" object:nil];
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"queryCollectGoodsInfoWithNoData" object:nil];
                });
            }
        } else {
            //请求失败
        }
    }];
}

- (void)deleteCollectGoodsInfoWithCollectId:(long)collectId {
    [PersonalPesRequest deleteCollectGoodsInfoWithColletId:collectId withBlock:^(NSDictionary *response, NSString *error) {
        if ([[response objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteCollectGoodsInfoSuccess" object:nil];
            });
        }
    }];
}

- (void)queryMemberAddressWithMemberId:(long)memberId {
    [PersonalPesRequest queryMemberAddressWithMemberId:memberId withBlock:^(NSDictionary *response, NSString *error) {
        if ([[response objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            if (![[response objectForKey:@"data"] isKindOfClass:[NSString class]]) {
                [self.addressInfos removeAllObjects];
                NSArray *array = [response objectForKey:@"data"];
                for (NSDictionary *dict in array) {
                    AddressInfo *info = [[AddressInfo alloc] init];
                    info.status = [[dict objectForKey:@"deliveryStatus"] unsignedLongValue];
                    info.name = [dict objectForKey:@"deliveryName"];
                    info.address = [dict objectForKey:@"deliveryAddress"];
                    info.addressId = [[dict objectForKey:@"deliveryId"] unsignedLongValue];
                    info.phone = [dict objectForKey:@"deliveryPhone"];
                    [self.addressInfos addObject:info];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"queryMemberAddressSuccess" object:nil];
                    });
                }
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"queryMemberAddressWithNoAddress" object:nil];
                });
            }
        }
    }];
}

- (void)addMemberAddressWithName:(NSString *)name withPhone:(NSString *)phone withAddress:(NSString *)address withStatus:(long)status withMemberId:(long)memberId {
    [PersonalPesRequest addMemberAddressWithName:name withPhone:phone withAddress:address withStatus:status withMemberId:memberId withBlock:^(NSDictionary *response, NSString *error) {
        if ([[response objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"addMemberAddressSuccess" object:nil];
            });
        }
    }];
}

- (void)updateMemberAddressWithName:(NSString *)name withPhone:(NSString *)phone withAddress:(NSString *)address withStatus:(long)status withAddressId:(long)addressId {
    [PersonalPesRequest updateMemberAddressWithName:name withPhone:phone withAddress:address withStatus:status withAddressId:addressId withBlock:^(NSDictionary *response, NSString *error) {
        if ([[response objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"updateMemberAddressSuccess" object:nil];
            });
        }
    }];
}

- (void)deleteMemberAddressWithAddressId:(long)addressId {
    [PersonalPesRequest deleteMembetAddressWithAddressId:addressId withBlock:^(NSDictionary *response, NSString *error) {
        if ([[response objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteMemberAddressSuccess" object:nil];
            });
        }
    }];
}

- (void)makeAddressDefaultWithAddressId:(long)addressId {
    [PersonalPesRequest makeAddressDefaultWithAddressId:addressId withBlock:^(NSDictionary *response, NSString *error) {
        if ([[response objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"makeAddressDefaultSuccess" object:nil];
            });
        }
    }];
}

- (void)cancelAddressDefaultWithAddressId:(long)addressId {
    [PersonalPesRequest cancelAddressDefaultWithAddressId:addressId withBlock:^(NSDictionary *response, NSString *error) {
        if ([[response objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"cancelAddressDefaultSuccess" object:nil];
            });
        }
    }];
}

- (void)queryMemberOrderGoodsInfoWithToken:(NSString *)token {
    [PersonalPesRequest queryMemberOrderGoodsInfoWithToken:token withBlock:^(NSDictionary *response, NSString *error) {
        if ([[response objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            [self.orderGoodsInfos removeAllObjects];
            if (![[response objectForKey:@"data"] isKindOfClass:[NSString class]]) {
                NSArray *array = [response objectForKey:@"data"];
                for (NSDictionary *dict in array) {
                    GoodsInfo *info = [[GoodsInfo alloc] init];
                    info.goodsParamValue = [dict objectForKey:@"goodsParameter"];
                    info.goodsOrderId = [[dict objectForKey:@"orderOfGoodsDetailId"] unsignedLongValue];
                    info.goodsCount = [[dict objectForKey:@"goodsCount"] unsignedLongValue];
                    info.goodsPrice = [[dict objectForKey:@"goodsPrice"] unsignedLongValue];
                    info.goodsOrderNum = [dict objectForKey:@"orderOfGoodsNum"];
                    
                    NSDictionary *goodsInfo = [dict objectForKey:@"goodsInfo"];
                    info.goodsName = [goodsInfo objectForKey:@"goodsName"];
                    info.goodsPic = [goodsInfo objectForKey:@"goodsPic"];
                    NSDictionary *goodsOrder = [dict objectForKey:@"orderOfGoods"];
                    info.goodsDate = [goodsOrder objectForKey:@"orderOfGoodsTime"];
                    NSDictionary *orderGoodsStatu = [dict objectForKey:@"orderInfoStatus"];
                    info.goodsOrderStatus = [orderGoodsStatu objectForKey:@"orderInfoStatusDetail"];
                    [self.orderGoodsInfos addObject:info];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"queryMemberOrderGoodsInfoSuccess" object:nil];
            });
        } else {
            //请求失败
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"queryMemberOrderGoodsInfoFaild" object:nil];
            });
        }
    }];
}

- (void)cancelMemberOrderGoodsInfoWithToken:(NSString *)token withOrderId:(long)orderId {
    [PersonalPesRequest cancelMemberOrderWithToken:token withOrderId:orderId withBlock:^(NSDictionary *response, NSString *error) {
        if ([[response objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"cancelMemberOrderGoodsInfoSuccess" object:nil];
            });
        }
    }];
}

- (void)backMemberOrderGoodsInfoWithToken:(NSString *)token withOrderId:(long)orderId {
    [PersonalPesRequest backMemberOrderWithToken:token withOrderId:orderId withBlock:^(NSDictionary *response, NSString *error) {
        if ([[response objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"backMemberOrderGoodsInfoSuccess" object:nil];
            });
        }
    }];
}

- (void)deleteMemberOrderGoodsInfoWithToken:(NSString *)token withOrderId:(long)orderId {
    [PersonalPesRequest deleteMemberOrderWithToken:token withOrderId:orderId withBlock:^(NSDictionary *response, NSString *error) {
        if ([[response objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteMemberOrderGoodsInfoSuccess" object:nil];
            });
        }
    }];
}

- (void)queryCameraManOrderInfoWithToken:(NSString *)token {
    [PersonalPesRequest queryCameraManOrderInfoWithToken:token withBlock:^(NSDictionary *response, NSString *error) {
        if ([[response objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            [self.cameraManOrderInfos removeAllObjects];
            if (![[response objectForKey:@"data"] isKindOfClass:[NSString class]]) {
                NSArray *array = [response objectForKey:@"data"];
                for (NSDictionary *dict in array) {
                    CameraManInfo *info = [[CameraManInfo alloc] init];
                    info.cameraManGroupName = [dict objectForKey:@"camerGroupName"];
                    info.cameraManOrderNum = [dict objectForKey:@"orderInfoNum"];
                    info.cameraManCreatDate = [dict objectForKey:@"creatTime"];
                    info.cameraManOrderDate = [dict objectForKey:@"orderDate"];
                    info.cameraManOrderId = [[dict objectForKey:@"orderInfoId"] unsignedLongValue];
                    NSDictionary *cameraManInfo = [dict objectForKey:@"cameraman"];
                    info.cameraManName = [cameraManInfo objectForKey:@"cameramanName"];
                    NSDictionary *status = [dict objectForKey:@"orderInfoStatus"];
                    info.cameraManOrderStatus = [status objectForKey:@"orderInfoStatusDetail"];
                    [self.cameraManOrderInfos addObject:info];
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"queryCameraManOrderInfoSuccess" object:nil];
        });
    }];
}

- (void)cancelCameraManOrderInfoWithToken:(NSString *)token withOrderId:(long)orderId {
    [PersonalPesRequest cancelCameraManOrderInfoWithToken:token withOrderId:orderId withBlock:^(NSDictionary *response, NSString *error) {
        if ([[response objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"cancelCameraManOrderInfoSuccess" object:nil];
            });
        }
    }];
}

- (void)backCameraManOrderInfoWithToken:(NSString *)token withOrderId:(long)orderId {
    [PersonalPesRequest backCameraManOrderInfoWithToken:token withOrderId:orderId withBlock:^(NSDictionary *response, NSString *error) {
        if ([[response objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"backCameraManOrderInfoSuccess" object:nil];
            });
        }
    }];
}

- (void)deleteCameraManOrderInfoWithToken:(NSString *)token withOrderId:(long)orderId {
    [PersonalPesRequest deleteCameraManOrderInfoWithToken:token withOrderId:orderId withBlock:^(NSDictionary *response, NSString *error) {
        if ([[response objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteCameraManOrderInfoSuccess" object:nil];
            });
        }
    }];
}

- (void)updateApp {
    [PersonalPesRequest updateAppWithBlock:^(NSDictionary *response, NSString *error) {
        if ([[response objectForKey:@"errorCode"] unsignedLongValue]== 0) {
//            NSString *data = [response objectForKey:@"data"];
        }
    }];
}

- (void)updateMemberAvatarWithToken:(NSString *)token withUpFile:(NSData *)data {
    [PersonalPesRequest updateMemberAvatarWithToken:token withUpfile:data withBlock:^(NSDictionary *response, NSString *error) {
        
    }];
}

@end
