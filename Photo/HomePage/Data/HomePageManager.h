//
//  HomePageManager.h
//  Photo
//
//  Created by malin  on 2017/8/1.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomePagePesRequest.h"

@interface HomePageManager : NSObject

DECLARE_SINGLETON_FOR_CLASS(HomePageManager)

@property (nonatomic, strong) NSMutableArray *scrollViewImages;
@property (nonatomic, strong) NSMutableArray *cameraGroups;
@property (nonatomic, strong) NSMutableArray *cameraTeams;
@property (nonatomic, strong) NSMutableArray *cameraMans;

- (void)loadScrollViewImages;

- (void)queryCameraGroup;

- (void)queryCameraTeamWithGroupId:(long)groupId;

- (void)queryCameraManWithTeamId:(long)teamId;

@end
