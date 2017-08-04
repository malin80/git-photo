//
//  LoginManager.m
//  Photo
//
//  Created by malin  on 2017/8/1.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "LoginManager.h"

@implementation LoginManager

SYNTHESIZE_SINGLETON_FOR_CLASS(LoginManager)

- (void)getLoginIdentifyCodeWithPhoneNumber:(NSString *)number {
    [LoginPesRequest getLoginIdentifyCodeWithPhoneNumber:number withBlock:^(NSDictionary *response, NSString *error) {
        
    }];
}

- (void)loginWithPhoneNumber:(NSString *)number withIdentifyCode:(NSString *)code withLoginType:(NSInteger)loginType withAppId:(NSString *)appId {
    [LoginPesRequest loginWithPhoneNumber:number withIdentifyCode:code withLoginType:loginType withAppId:appId withBlock:^(NSDictionary *response, NSString *error) {
        if ([[response objectForKey:@"errorCode"] unsignedLongValue] == 0) {
            NSDictionary *data = [response objectForKey:@"data"];
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"shuju"];
            [[NSUserDefaults standardUserDefaults] setObject:@"isLogin" forKey:@"isLogin"];

            if ([self.delegate respondsToSelector:@selector(loginSuccess)]) {
                [self.delegate loginSuccess];
            }
        }
    }];
}

- (void)getMemberInfo {
    MemberInfo *info = [[MemberInfo alloc] init];
    NSDictionary *dict=[[NSUserDefaults standardUserDefaults]objectForKey:@"shuju"];
    
    info.memberId = [[dict objectForKey:@"memberId"] unsignedLongValue];
    info.memberPhone = [dict objectForKey:@"memberPhone"];
    info.memberPwd = [dict objectForKey:@"memberPwd"];
    info.memberNickName = [[dict objectForKey:@"memberDetail"] objectForKey:@"pickName"];
    info.memberName = [[dict objectForKey:@"memberDetail"] objectForKey:@"memberName"];
    info.memberSex = [[dict objectForKey:@"memberDetail"] objectForKey:@"memberSex"];
    info.memberMarry = [[dict objectForKey:@"memberDetail"] objectForKey:@"memberMarry"];
    info.memberPic = [[dict objectForKey:@"memberDetail"] objectForKey:@"memberPic"];
    info.safeCodeValue = [[dict objectForKey:@"safeCode"] objectForKey:@"safeCodeValue"];
    self.memberInfo = info;
}

@end
