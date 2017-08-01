//
//  LoginManager.m
//  Photo
//
//  Created by malin  on 2017/8/1.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "LoginManager.h"
#import "MemberInfo.h"

@implementation LoginManager

SYNTHESIZE_SINGLETON_FOR_CLASS(LoginManager)

- (void)getLoginIdentifyCodeWithPhoneNumber:(NSString *)number {
    [LoginPesRequest getLoginIdentifyCodeWithPhoneNumber:number withBlock:^(NSDictionary *response, NSString *error) {
        
    }];
}

- (void)loginWithPhoneNumber:(NSString *)number withIdentifyCode:(NSString *)code withLoginType:(NSInteger)loginType withAppId:(NSString *)appId {
    [LoginPesRequest loginWithPhoneNumber:number withIdentifyCode:code withLoginType:loginType withAppId:appId withBlock:^(NSDictionary *response, NSString *error) {
        if ([[response objectForKey:@"errorCode"] unsignedLongValue] == 0) {
            MemberInfo *info = [[MemberInfo alloc] init];
            NSDictionary *data = [response objectForKey:@"data"];
            NSDictionary *safeCode = [data objectForKey:@"safeCode"];
            NSDictionary *memberDetail = [data objectForKey:@"memberDetail"];
            info.memberId = [[data objectForKey:@"memberId"] unsignedLongValue];
            info.memberPhone = [data objectForKey:@"memberPhone"];
            info.memberPwd = [data objectForKey:@"memberPwd"];
            info.memberNickName = [memberDetail objectForKey:@"pickName"];
            info.memberName = [memberDetail objectForKey:@"memberName"];
            info.memberSex = [memberDetail objectForKey:@"memberSex"];
            info.memberBirthday = [memberDetail objectForKey:@"memberBirthday"];
            info.memberMarry = [memberDetail objectForKey:@"memberMarry"];
            info.safeCodeValue = [safeCode objectForKey:@"safeCodeValue"];
        }
    }];
}

@end
