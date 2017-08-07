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
            [[NSUserDefaults standardUserDefaults] setObject:@"isLogin" forKey:@"isLogin"];

            MemberInfo *info = [[MemberInfo alloc] init];
            NSDictionary *data = [response objectForKey:@"data"];
            NSDictionary *safeCode = [data objectForKey:@"safeCode"];
            NSDictionary *memberDetail = [data objectForKey:@"memberDetail"];
            info.memberId = [[data objectForKey:@"memberId"] unsignedLongValue];
            [[NSUserDefaults standardUserDefaults] setObject:@(info.memberId) forKey:@"memberId"];
            
            info.memberPhone = [data objectForKey:@"memberPhone"];
            [[NSUserDefaults standardUserDefaults] setObject:info.memberPhone forKey:@"memberPhone"];
            
            info.memberPwd = [data objectForKey:@"memberPwd"];
            [[NSUserDefaults standardUserDefaults] setObject:info.memberPwd forKey:@"memberPwd"];
            
            info.memberNickName = [memberDetail objectForKey:@"pickName"];
            [[NSUserDefaults standardUserDefaults] setObject:info.memberNickName forKey:@"memberNickName"];
            
            info.memberName = [memberDetail objectForKey:@"memberName"];
            [[NSUserDefaults standardUserDefaults] setObject:info.memberName forKey:@"memberName"];

            info.memberSex = [memberDetail objectForKey:@"memberSex"];
            [[NSUserDefaults standardUserDefaults] setObject:info.memberSex forKey:@"memberSex"];

            info.memberBirthday = [memberDetail objectForKey:@"memberBirthday"];
            [[NSUserDefaults standardUserDefaults] setObject:info.memberBirthday forKey:@"memberBirthday"];

            info.memberPic = [memberDetail objectForKey:@"memberPic"];
            [[NSUserDefaults standardUserDefaults] setObject:info.memberPic forKey:@"memberPic"];

            info.memberMarry = [memberDetail objectForKey:@"memberMarry"];
            [[NSUserDefaults standardUserDefaults] setObject:info.memberMarry forKey:@"memberMarry"];

            info.safeCodeValue = [safeCode objectForKey:@"safeCodeValue"];
            [[NSUserDefaults standardUserDefaults] setObject:info.safeCodeValue forKey:@"safeCodeValue"];

            if (loginType == 1) {
                NSDictionary *dict = [NSDictionary dictionaryWithObject:info forKey:@"memberInfo"];
                [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"memberInfo"];
            }

            
            if ([self.delegate respondsToSelector:@selector(loginSuccess)]) {
                [self.delegate loginSuccess];
            }
        }
    }];
}

- (void)getMemberInfo {
    self.memberInfo = [[MemberInfo alloc] init];
    MemberInfo *info = [[MemberInfo alloc] init];
    
    info.memberId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"memberId"] unsignedLongValue];
    info.memberPhone = [[NSUserDefaults standardUserDefaults] stringForKey:@"memberPhone"];
    info.memberPwd = [[NSUserDefaults standardUserDefaults] stringForKey:@"memberPwd"];
    info.memberNickName = [[NSUserDefaults standardUserDefaults] stringForKey:@"memberNickName"];
    info.memberName = [[NSUserDefaults standardUserDefaults] stringForKey:@"memberName"];
    info.memberSex = [[NSUserDefaults standardUserDefaults] stringForKey:@"memberSex"];
    info.memberMarry = [[NSUserDefaults standardUserDefaults] stringForKey:@"memberMarry"];
    info.memberPic = [[NSUserDefaults standardUserDefaults] stringForKey:@"memberPic"];
    info.safeCodeValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"safeCodeValue"];
    self.memberInfo = info;
}

@end
