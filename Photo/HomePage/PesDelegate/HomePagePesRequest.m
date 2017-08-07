//
//  HomePagePesRequest.m
//  Photo
//
//  Created by malin  on 2017/7/28.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "HomePagePesRequest.h"

@implementation HomePagePesRequest

+ (void)loadPageScrollViewImage:(void(^)(NSDictionary *responseObject,NSString *error))finished {
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"HomeSlideControl/queryHomeSlide.do" dic:nil finished:finished];
}

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

@end
