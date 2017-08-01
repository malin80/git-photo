//
//  LoginInfo.h
//  Photo
//
//  Created by malin  on 2017/7/31.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LoginType) {
    LoginTypePassword       = 0,
    LoginTypeIdentifyCode   = 1,
};

@interface LoginInfo : NSObject

@property (nonatomic, assign) LoginType loginType;

@end
