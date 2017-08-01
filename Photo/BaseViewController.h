//
//  BaseViewController.h
//  Photo
//
//  Created by malin  on 2017/7/26.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property (nonatomic, strong)MBProgressHUD *hub1;
- (void)showlongtext:(NSString *)str;
- (void)showtext:(NSString *)test;

- (void)show;
- (void)show:(NSString *)test;
- (void)hiddenHub1;
@end
