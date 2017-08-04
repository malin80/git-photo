//
//  LoginManager.h
//  Photo
//
//  Created by malin  on 2017/8/1.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginPesRequest.h"
#import "MemberInfo.h"

@protocol LoginManagerDelegate <NSObject>

@optional
- (void)loginSuccess;

@end

@interface LoginManager : NSObject

DECLARE_SINGLETON_FOR_CLASS(LoginManager)

@property (nonatomic, weak)  id<LoginManagerDelegate> delegate;
@property (nonatomic, strong) MemberInfo *memberInfo;


- (void)getLoginIdentifyCodeWithPhoneNumber:(NSString *)number;

- (void)loginWithPhoneNumber:(NSString *)number withIdentifyCode:(NSString *)code withLoginType:(NSInteger)loginType withAppId:(NSString *)appId;

- (void)getMemberInfo;

@end
