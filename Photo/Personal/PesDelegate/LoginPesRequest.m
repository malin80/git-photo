//
//  LoginPesRequest.m
//  Photo
//
//  Created by malin  on 2017/8/1.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "LoginPesRequest.h"

@implementation LoginPesRequest

+ (void)getLoginIdentifyCodeWithPhoneNumber:(NSString *)number withBlock:(void (^)(NSDictionary *response, NSString *error))finished {
    NSDictionary *parameters = [NSDictionary dictionary];
    parameters = @{@"mobile":number};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"SendsmsControl/Sendsms.do" dic:parameters finished:finished];
}

+ (void)loginWithPhoneNumber:(NSString *)number withIdentifyCode:(NSString *)code withLoginType:(NSInteger)loginType withAppId:(NSString *)appId withBlock:(void (^)(NSDictionary *response, NSString *error))finished {
    NSDictionary *parameters = nil;
    parameters = @{@"memberPhone":number, @"memberCode":code, @"loginType":@(loginType), @"appid":appId};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"MemberControl/login.do" dic:parameters finished:finished];
}

@end
