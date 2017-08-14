//
//  DressManDetailViewController.h
//  Photo
//
//  Created by malin  on 2017/8/10.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DressManInfo.h"
#import "BaseViewController.h"

@interface DressManDetailViewController : BaseViewController

@property (nonatomic, strong) DressManInfo *dressManInfo;
@property (nonatomic, assign) BOOL isSelectController;

@end
