//
//  CameraManInfo.h
//  Photo
//
//  Created by malin  on 2017/8/7.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CameraManInfo : NSObject

@property (nonatomic, copy) NSString *cameraManPic;
@property (nonatomic, copy) NSString *cameraManName;
@property (nonatomic, copy) NSString *cameraManSynopsis;
@property (nonatomic, copy) NSString *cameraManPwd;
@property (nonatomic, copy) NSString *cameraManNum;
@property (nonatomic, copy) NSString *cameraManContent;
@property (nonatomic, copy) NSString *cameraManComment;
@property (nonatomic, copy) NSString *cameraManGroupName;
@property (nonatomic, copy) NSString *cameraManOrderNum;
@property (nonatomic, copy) NSString *cameraManCreatDate;
@property (nonatomic, copy) NSString *cameraManOrderDate;
@property (nonatomic, copy) NSString *cameraManOrderStatus;
@property (nonatomic, assign) long cameraManId;
@property (nonatomic, assign) long isSubscribe;
@property (nonatomic, assign) long subscribeCount;
@property (nonatomic, assign) long commentCount;
@property (nonatomic, assign) long worksOfCameraMan;
@property (nonatomic, assign) long cameraManOrderId;
@property (nonatomic, strong) NSArray *worksList;
@property (nonatomic, strong) NSArray *commentList;
@property (nonatomic, strong) NSArray *scheduleList;

@end
