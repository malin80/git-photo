//
//  CameraViewController.h
//  Photo
//
//  Created by malin  on 2017/7/31.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "TYTabPagerBar.h"
#import "TYPagerController.h"
@interface CameraViewController : BaseViewController<TYTabPagerBarDataSource,TYTabPagerBarDelegate,TYPagerControllerDataSource,TYPagerControllerDelegate>
@property (nonatomic, weak) TYTabPagerBar *tabBar;
@property (nonatomic, weak) TYPagerController *pagerController;
@property (nonatomic,strong) NSMutableArray *sringArry;
@end
