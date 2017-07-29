//
//  OrderManageViewController.h
//  Photo
//
//  Created by 陈炳文 on 2017/7/28.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "BaseViewController.h"
#import "NavigationBar.h"
#import "DLTabedSlideView.h"
#import "BookOrderViewController.h"
#import "ShopOrderViewController.h"
@interface OrderManageViewController : BaseViewController<NavigationBarDelegate>
@property (weak, nonatomic) IBOutlet DLTabedSlideView *tabedSlideView;

@end
