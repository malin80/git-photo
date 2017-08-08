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

@interface CameraManager : NSObject

DECLARE_SINGLETON_FOR_CLASS(CameraManager)


@property (nonatomic, strong) NSMutableArray *cameraGroups;
@property (nonatomic, strong) NSMutableArray *cameraTeams;
@property (nonatomic, strong) NSMutableArray *cameraMans;
@property (nonatomic, strong) CameraManInfo *cameraManInfo;


- (void)queryCameraGroup;

- (void)queryCameraTeamWithGroupId:(long)groupId;

- (void)queryCameraManWithTeamId:(long)teamId;

- (void)queryCameraManDetailWithId:(long)cameraManId;

@end
