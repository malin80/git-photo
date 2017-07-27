//
//  LeadViewController.h
//  Xiufenqi2.0
//
//  Created by 不丕 on 16/11/8.
//  Copyright © 2016年 艾蒂尔文化传媒有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabbarViewController.h"

typedef void(^leadBlock)();
@interface LeadViewController : UIViewController<UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView *scrollview;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, copy)leadBlock block;
@end
