//
//  HomePageManager.m
//  Photo
//
//  Created by malin  on 2017/8/1.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "HomePageManager.h"
#import "HomePageScrollViewInfo.h"
#import "HomePageCameraGroupInfo.h"
#import "CameraTeamInfo.h"

@implementation HomePageManager

SYNTHESIZE_SINGLETON_FOR_CLASS(HomePageManager)

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scrollViewImages = [NSMutableArray array];
        self.cameraGroups = [NSMutableArray array];
        self.cameraTeams = [NSMutableArray array];
    }
    return self;
}

- (void)loadScrollViewImages {
    if (self.scrollViewImages.count != 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loadScrollViewImagesSuccess" object:nil];
        });
        return;
    }
    [HomePagePesRequest loadPageScrollViewImage:^(NSDictionary *responseObject,NSString *error){
        NSArray *urlArray = [responseObject objectForKey:@"data"];
        for (NSDictionary *dict in urlArray) {
            HomePageScrollViewInfo *info = [[HomePageScrollViewInfo alloc] init];
            NSString *urlString = [dict objectForKey:@"homeSlideImgUrl"];
            NSInteger imageId = [[dict objectForKey:@"homeSlideId"] integerValue];
            info.imageUrl = urlString;
            info.imageId = &(imageId);
            [self.scrollViewImages addObject:info];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loadScrollViewImagesSuccess" object:nil];
        });
    }];
}

- (void)queryCameraGroup {
    [HomePagePesRequest queryCameraGroup:^(NSDictionary *responseObject, NSString *error) {
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
    [HomePagePesRequest queryCameraTeamWithGroupId:groupId withBlock:^(NSDictionary *responseObject, NSString *error) {
        if ([[responseObject objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            NSArray *array = [responseObject objectForKey:@"data"];
            NSLog(@"%lu",(unsigned long)array.count);
            
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

@end
