//
//  LoginPesRequest.h
//  Photo
//
//  Created by malin  on 2017/8/1.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PesRequest.h"

@interface LoginPesRequest : NSObject

+ (void)getLoginIdentifyCodeWithPhoneNumber:(NSString *)number withBlock:(void (^)(NSDictionary *response, NSString *error))finished;

+ (void)loginWithPhoneNumber:(NSString *)number withIdentifyCode:(NSString *)code withLoginType:(NSInteger)loginType withAppId:(NSString *)appId withBlock:(void (^)(NSDictionary *response, NSString *error))finished;
@end
