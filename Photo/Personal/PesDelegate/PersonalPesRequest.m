//
//  PersonalPesRequest.m
//  Photo
//
//  Created by malin  on 2017/8/1.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "PersonalPesRequest.h"
#import "PesRequest.h"

@implementation PersonalPesRequest

+ (void)updateMemberInfoWithNickName:(NSString *)nickName
                      withMemberName:(NSString *)memberName
                       withMemberSex:(NSString *)memberSex
                     withMemberMarry:(NSString *)memberMarry
                  withMemberBirthday:(NSString *)memberBirthday
                           withToken:(NSString *)token
                           withBlock:(void (^)(NSDictionary *response, NSString *error))finished {
    if (memberBirthday == nil) {
        memberBirthday = @"";
    }
    NSDictionary *dict = @{@"nickName":nickName, @"memberName":memberName, @"memberSex":memberSex, @"memberMarry":memberMarry, @"memberBirthday":memberBirthday, @"token":token};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"MemberControl/updateMemberDetail.do" dic:dict finished:finished];
}

+ (void)updatePasswordWithToke:(NSString *)token withOldCode:(NSString *)oldCode withNewCode:(NSString *)newCode wihhUpdateType:(int)type withBlock:(void (^)(NSDictionary *response, NSString *error))finished {
    NSDictionary *dict = @{@"token":token, @"oldCode":oldCode, @"newCode":newCode, @"updateType":@(type)};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"MemberControl/updateMemberPwd.do" dic:dict finished:finished];
}


+ (void)queryCollectGoodsInfoWithMemberId:(long)memberId withBlock:(void (^)(NSDictionary *response, NSString *error))finished {
    NSDictionary *dict = @{@"memberId":@(memberId)};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"CollectionInfoControl/queryCollectionInfo.do" dic:dict finished:finished];
}

@end
