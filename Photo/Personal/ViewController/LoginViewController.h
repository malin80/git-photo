//
//  LoginViewController.h
//  Photo
//
//  Created by malin  on 2017/7/27.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@protocol LoginViewControllerDelegate <NSObject>

@optional
- (void)loginViewControllerGoBack;

@end

typedef void(^loginBlock)();

@interface LoginViewController : BaseViewController

@property (nonatomic, copy)loginBlock block;

@property(nonatomic, weak)  id<LoginViewControllerDelegate> delegate;


@end
