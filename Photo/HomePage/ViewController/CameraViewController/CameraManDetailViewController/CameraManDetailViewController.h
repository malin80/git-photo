//
//  CameraManDetailViewController.h
//  Photo
//
//  Created by malin  on 2017/8/7.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CameraManInfo.h"

@interface CameraManDetailViewController : BaseViewController

@property (nonatomic, strong) CameraManInfo *cameraManInfo;
@property (nonatomic, assign) BOOL isSelectController;

@end
