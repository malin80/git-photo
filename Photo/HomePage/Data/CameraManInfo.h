//
//  CameraManInfo.h
//  Photo
//
//  Created by malin  on 2017/8/7.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CameraManInfo : NSObject

@property (nonatomic, strong) NSString *cameraManPic;
@property (nonatomic, strong) NSString *cameraManName;
@property (nonatomic, strong) NSString *cameraManSynopsis;
@property (nonatomic, strong) NSString *cameraManPwd;
@property (nonatomic, strong) NSString *cameraManNum;
@property (nonatomic, strong) NSString *cameraManContent;
@property (nonatomic, strong) NSString *cameraManComment;
@property (nonatomic, assign) long cameraManId;
@property (nonatomic, assign) long isSubscribe;
@property (nonatomic, assign) long subscribeCount;
@property (nonatomic, assign) long commentCount;
@property (nonatomic, assign) long worksOfCameraMan;

@property (nonatomic, strong) NSArray *worksList;
@property (nonatomic, strong) NSArray *commentList;
@property (nonatomic, strong) NSArray *scheduleList;

@end
