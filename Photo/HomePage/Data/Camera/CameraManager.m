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
#import "DressManInfo.h"
#import "ImageInfo.h"

@implementation CameraManager

SYNTHESIZE_SINGLETON_FOR_CLASS(CameraManager)

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cameraGroups = [NSMutableArray array];
        self.cameraTeams = [NSMutableArray array];
        self.cameraMans = [NSMutableArray array];
        self.dressMans = [NSMutableArray array];
        self.cameraManInfo = [[CameraManInfo alloc] init];
        self.dressManInfo = [[DressManInfo alloc] init];
        self.scrollViewImages = [NSMutableArray array];
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
            NSLog(@"%@",responseObject);
            [self.cameraTeams removeAllObjects];
            if (![[responseObject objectForKey:@"data"] isKindOfClass:[NSString class]]) {
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
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"queryCameraTeamWithGroupIdSuccess" object:nil];
            });
        }
    }];
}

- (void)queryCameraManWithTeamId:(long)teamId {
    [CameraPesRequest queryCarmeraManWithTeamId:teamId withBlock:^(NSDictionary *responseObject, NSString *error) {
        if ([[responseObject objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            [self.cameraMans removeAllObjects];
            if (![[responseObject objectForKey:@"data"] isKindOfClass:[NSString class]]) {
                NSArray *array = [responseObject objectForKey:@"data"];
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
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"queryCameraManSuccess" object:nil];
            });
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

- (void)queryDressManWithTeamId:(long)teamId {
    [CameraPesRequest queryDressManWithTeamId:teamId withBlock:^(NSDictionary *responseObject, NSString *error) {
        if ([[responseObject objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            if (![[responseObject objectForKey:@"data"] isKindOfClass:[NSString class]]) {
                [self.dressMans removeAllObjects];
                NSArray *array = [responseObject objectForKey:@"data"];
                if (array.count > 0) {
                    for (NSDictionary *dict in array) {
                        DressManInfo *info = [[DressManInfo alloc] init];
                        info.dressManPic = [dict objectForKey:@"dresserPic"];
                        info.subscribeCount = [[dict objectForKey:@"dresserSubscribeCount"] unsignedLongValue];
                        info.dressManName = [dict objectForKey:@"dresserName"];
                        info.dressManSynopsis = [dict objectForKey:@"dresserSynopsis"];
                        info.dressManId = [[dict objectForKey:@"dresserId"] unsignedLongValue];
                        info.dressManNum = [dict objectForKey:@"dresserNum"];
                        info.dressManPwd = [dict objectForKey:@"dresserPwd"];
                        info.dressManContent = [dict objectForKey:@"dresserContent"];
                        info.worksOfDressMan = [[dict objectForKey:@"worksOfDresserCount"] unsignedLongValue];
                        info.commentCount = [[dict objectForKey:@"commentCount"] unsignedLongValue];
                        info.dressManComment = [dict objectForKey:@"dresserComment"];
                        [self.dressMans addObject:info];
                    }
                }
            }
        }
    }];
}

- (void)queryDressManDetailWithId:(long)dressManId {
    [CameraPesRequest queryDressManDetailWithId:dressManId withBlock:^(NSDictionary *responseObject, NSString *error) {
        if ([[responseObject objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            NSDictionary *dict = [responseObject objectForKey:@"data"];
            self.dressManInfo.worksList = [dict objectForKey:@"worksOfDresserList"];
            self.dressManInfo.commentList = [dict objectForKey:@"commentList"];
            self.dressManInfo.scheduleList = [dict objectForKey:@"scheduleList"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"queryDressManDetailWithIdSuccess" object:nil];
            });
        }
    }];
}

- (void)orderCameraManWithCameraId:(long)cameraId withToken:(NSString *)token withDressId:(long)dressId withTime:(NSString *)time withType:(NSString *)type withGroupName:(NSString *)groupName withIndex:(int)index{
    [CameraPesRequest orderCameraManOrderWithCameraId:cameraId withToken:token withDressId:dressId withTime:time withType:type withCamerGroupName:groupName withBlock:^(NSDictionary *responseObject, NSString *error) {
        if ([[responseObject objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            NSString *payId = [responseObject objectForKey:@"data"];
            NSLog(@"%@",responseObject);
            if (index==0) {
                [self payByAliWithToken:token withGoodsPayId:@""withOrderPayId:payId];
            }else if (index==1){
                [self payByWxWithToken:token withGoodsPayId:@"" withOrderPayId:payId];
            }
        }
    }];
}

- (void)loadCameraRecommendImages {
    [CameraPesRequest loadCameraRecommendImagesWithBlock:^(NSDictionary *responseObject, NSString *error) {
        if ([[responseObject objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            NSArray *urlArray = [responseObject objectForKey:@"data"];
            for (NSDictionary *dict in urlArray) {
                ImageInfo *info = [[ImageInfo alloc] init];
                NSString *urlString = [dict objectForKey:@"camerSlideImgUrl"];
                NSInteger imageId = [[dict objectForKey:@"camerSlideId"] integerValue];
                info.imageUrl = urlString;
                info.imageId = &(imageId);
                [self.scrollViewImages addObject:info];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"loadScrollViewImagesSuccess" object:nil];
            });
        }
    }];
}
- (void)payByAliWithToken:(NSString *)token withGoodsPayId:(NSString *)goodsPayId withOrderPayId:(NSString *)orderPayId {
    [StorePesRequest payByAliWithToken:token withGoodsPayId:goodsPayId withOrderPayId:orderPayId withBlock:^(NSDictionary *responseObject, NSString *error) {
        if ([[responseObject objectForKey:@"errorCode"] intValue]==0) {
            NSLog(@"%@",responseObject);
            self.Paydata=[responseObject objectForKey:@"data"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"alipayaa" object:nil];
        }
    }];
}
- (void)payByWxWithToken:(NSString *)token withGoodsPayId:(NSString *)goodsPayId withOrderPayId:(NSString *)orderPayId {
    [StorePesRequest payByWechatWithToken:token withGoodsPayId:goodsPayId withOrderPayId:orderPayId withBlock:^(NSDictionary *responseObject, NSString *error) {
        if ([[responseObject objectForKey:@"errorCode"] intValue]==0) {
            NSLog(@"%@",responseObject);
            self.wxDic=[responseObject objectForKey:@"data"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"wxpayaa" object:nil];
        }
    }];
}

@end
