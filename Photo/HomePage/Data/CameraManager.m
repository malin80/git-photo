//
//  CameraManager.m
//  Photo
//
//  Created by malin  on 2017/8/8.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "CameraManager.h"
#import "HomePageCameraGroupInfo.h"
#import "CameraTeamInfo.h"
#import "CameraManInfo.h"

@implementation CameraManager

SYNTHESIZE_SINGLETON_FOR_CLASS(CameraManager)

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cameraGroups = [NSMutableArray array];
        self.cameraTeams = [NSMutableArray array];
        self.cameraMans = [NSMutableArray array];
        self.cameraManInfo = [[CameraManInfo alloc] init];
    }
    return self;
}

- (void)queryCameraGroup {
    [CameraPesRequest queryCameraGroup:^(NSDictionary *responseObject, NSString *error) {
        if ([[responseObject objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            NSArray *data = [responseObject objectForKey:@"data"];
            for (NSDictionary *dict in data) {
                HomePageCameraGroupInfo *info = [[HomePageCameraGroupInfo alloc] init];
                info.cameraGroupName = [dict objectForKey:@"camerGroupName"];
                info.cameraGroupId = [[dict objectForKey:@"camerGroupId"] unsignedLongValue];
                [self.cameraGroups addObject:info];
            }
        }
    }];
}

- (void)queryCameraTeamWithGroupId:(long)groupId {
    [CameraPesRequest queryCameraTeamWithGroupId:groupId withBlock:^(NSDictionary *responseObject, NSString *error) {
        if ([[responseObject objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            NSArray *array = [responseObject objectForKey:@"data"];
            
            if (array.count > 0) {
                for (NSDictionary *dict in array) {
                    CameraTeamInfo *info = [[CameraTeamInfo alloc] init];
                    info.teamPic = [dict objectForKey:@"teamPic"];
                    info.teamName = [dict objectForKey:@"teamName"];
                    info.teamDetail = [dict objectForKey:@"teamDetail"];
                    info.teamServieInfo = [dict objectForKey:@"teamServiceInfo"];
                    info.teamId = [[dict objectForKey:@"teamId"] unsignedLongValue];
                    info.teamPrice = [[dict objectForKey:@"teamPrice"] unsignedLongValue];
                    [self.cameraTeams addObject:info];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"queryCameraTeamWithGroupIdSuccess" object:nil];
                });
            } else {
                
            }
        }
    }];
}

- (void)queryCameraManWithTeamId:(long)teamId {
    [CameraPesRequest queryCarmeraManWithTeamId:teamId withBlock:^(NSDictionary *responseObject, NSString *error) {
        if ([[responseObject objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            NSArray *array = [responseObject objectForKey:@"data"];
            [self.cameraMans removeAllObjects];
            if (array.count > 0) {
                for (NSDictionary *dict in array) {
                    CameraManInfo *info = [[CameraManInfo alloc] init];
                    info.cameraManPic = [dict objectForKey:@"cameramanPic"];
                    info.subscribeCount = [[dict objectForKey:@"subscribeCount"] unsignedLongValue];
                    info.cameraManName = [dict objectForKey:@"cameramanName"];
                    info.cameraManSynopsis = [dict objectForKey:@"cameramanSynopsis"];
                    info.cameraManId = [[dict objectForKey:@"cameramanId"] unsignedLongValue];
                    info.cameraManNum = [dict objectForKey:@"cameramanNum"];
                    info.cameraManPwd = [dict objectForKey:@"cameramanPwd"];
                    info.cameraManContent = [dict objectForKey:@"cameramanContent"];
                    info.worksOfCameraMan = [[dict objectForKey:@"worksOfCameramanCount"] unsignedLongValue];
                    info.isSubscribe = [[dict objectForKey:@"isSubscribe"] unsignedLongValue];
                    info.commentCount = [[dict objectForKey:@"commentCount"] unsignedLongValue];
                    info.cameraManComment = [dict objectForKey:@"cameramanComment"];
                    [self.cameraMans addObject:info];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"queryCameraManSuccess" object:nil];
                });
            }
        }
    }];
}

- (void)queryCameraManDetailWithId:(long)cameraManId {
    [CameraPesRequest queryCameraManDetailWithId:cameraManId withBlock:^(NSDictionary *responseObject, NSString *error) {
        if ([[responseObject objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            NSDictionary *dict = [responseObject objectForKey:@"data"];
            self.cameraManInfo.worksList = [dict objectForKey:@"worksOfCameramanList"];
            self.cameraManInfo.commentList = [dict objectForKey:@"commentList"];
            self.cameraManInfo.scheduleList = [dict objectForKey:@"scheduleList"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"queryCameraManDetailWithIdSuccess" object:nil];
            });
        }
    }];
}

@end
