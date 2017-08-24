//
//  CameraManager.h
//  Photo
//
//  Created by malin  on 2017/8/8.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CameraPesRequest.h"
#import "CameraManInfo.h"
#import "DressManInfo.h"
#import "StorePesRequest.h"

@interface CameraManager : NSObject

DECLARE_SINGLETON_FOR_CLASS(CameraManager)


@property (nonatomic, strong) NSMutableArray *cameraGroups;
@property (nonatomic, strong) NSMutableArray *cameraTeams;
@property (nonatomic, strong) NSMutableArray *cameraMans;
@property (nonatomic, strong) NSMutableArray *dressMans;
@property (nonatomic, strong) CameraManInfo *cameraManInfo;
@property (nonatomic, strong) DressManInfo *dressManInfo;
@property (nonatomic, strong) CameraManInfo *selectedCameraManInfo;
@property (nonatomic, strong) DressManInfo *selectedDressManInfo;
@property (nonatomic, copy)   NSString *selectedTime;
@property (nonatomic, strong) NSMutableArray *scrollViewImages;
@property (nonatomic, copy) NSString *Paydata;
@property (nonatomic, strong)NSDictionary *wxDic;
@property (nonatomic, copy) NSString *commentImages;

- (void)queryCameraGroup;

- (void)queryCameraTeamWithGroupId:(long)groupId;

- (void)queryCameraManWithTeamId:(long)teamId;

- (void)queryCameraManDetailWithId:(long)cameraManId;

- (void)queryDressManWithTeamId:(long)teamId;

- (void)queryDressManDetailWithId:(long)dressManId;

- (void)orderCameraManWithCameraId:(long)cameraId withToken:(NSString *)token withDressId:(long)dressId withTime:(NSString *)time withType:(NSString *)type withGroupName:(NSString *)groupName withIndex:(int)index;

- (void)loadCameraRecommendImages;

@end
