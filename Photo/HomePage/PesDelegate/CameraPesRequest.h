//
//  CameraPesRequest.h
//  Photo
//
//  Created by malin  on 2017/8/8.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PesRequest.h"

@interface CameraPesRequest : NSObject

+ (void)queryCameraGroup:(void(^)(NSDictionary *responseObject,NSString *error))finished;

+ (void)queryCameraTeamWithGroupId:(long)groupId withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished;

+ (void)queryCarmeraManWithTeamId:(long)teamId withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished;

+ (void)queryCameraManDetailWithId:(long)cameraManId withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished;

+ (void)queryDressManWithTeamId:(long)teamId withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished;

+ (void)queryDressManDetailWithId:(long)dressManId withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished;

+ (void)orderCameraManOrderWithCameraId:(long)cameraManId withToken:(NSString *)token withDressId:(long)dressId withTime:(NSString *)time withType:(NSString *)type withCamerGroupName:(NSString *)groupName withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished;

+ (void)loadCameraRecommendImagesWithBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished;

@end
