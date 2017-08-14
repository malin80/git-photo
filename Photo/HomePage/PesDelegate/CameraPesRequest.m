//
//  CameraPesRequest.m
//  Photo
//
//  Created by malin  on 2017/8/8.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "CameraPesRequest.h"

@implementation CameraPesRequest

+ (void)queryCameraGroup:(void(^)(NSDictionary *responseObject,NSString *error))finished{
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"CamerGroupControl/selectAllCamerGroup.do" dic:nil finished:finished];
}

+ (void)queryCameraTeamWithGroupId:(long)groupId withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished {
    NSDictionary *dict = @{@"camerGroupId":@(groupId)};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"TeamControl/selectTeamByCamerGroup.do" dic:dict finished:finished];
}

+ (void)queryCarmeraManWithTeamId:(long)teamId withBlock:(void (^)(NSDictionary *, NSString *))finished {
    NSDictionary *dict = @{@"teamId":@(teamId)};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"CameramanControl/queryCameramanByTeam.do" dic:dict finished:finished];
}

+ (void)queryCameraManDetailWithId:(long)cameraManId withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished {
    NSDictionary *dict = @{@"cameramanId":@(cameraManId)};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"CameramanControl/queryCameramanById.do" dic:dict finished:finished];
}

+ (void)queryDressManWithTeamId:(long)teamId withBlock:(void (^)(NSDictionary *, NSString *))finished {
    NSDictionary *dict = @{@"teamId":@(teamId)};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"DresserControl/queryDresserByTeam.do" dic:dict finished:finished];
}

+ (void)queryDressManDetailWithId:(long)dressManId withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished {
    NSDictionary *dict = @{@"dresserId":@(dressManId)};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"DresserControl/queryDresserById.do" dic:dict finished:finished];
}

+ (void)orderCameraManOrderWithCameraId:(long)cameraManId withToken:(NSString *)token withDressId:(long)dressId withTime:(NSString *)time withType:(NSString *)type withCamerGroupName:(NSString *)groupName withBlock:(void (^)(NSDictionary *, NSString *))finished {
    NSDictionary *dict = @{@"cameramanId":@(cameraManId), @"token":token, @"dresserId":@(dressId), @"time":time, @"type":type, @"camerGroupName":groupName};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"OrderInfoControl/saveOrderInfo.do" dic:dict finished:finished];
}

+ (void)loadCameraRecommendImagesWithBlock:(void (^)(NSDictionary *, NSString *))finished {
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"CamerSlideControl/queryCamerSlide.do" dic:nil finished:finished];
}


@end
