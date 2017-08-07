//
//  PersonalManager.m
//  Photo
//
//  Created by malin  on 2017/8/4.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "PersonalManager.h"
#import "PersonalPesRequest.h"
#import "LoginManager.h"
#import "CollectGoodsInfo.h"

@implementation PersonalManager
SYNTHESIZE_SINGLETON_FOR_CLASS(PersonalManager)

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.collectGoodsInfos = [NSMutableArray array];
    }
    return self;
}

- (void)updateMemberInfoWithNickName:(NSString *)nickName
                      withMemberName:(NSString *)memberName
                       withMemberSex:(NSString *)memberSex
                     withMemberMarry:(NSString *)memberMarry
                  withMemberBirthday:(NSString *)memberBirthday
                           withToken:(NSString *)token {
    [PersonalPesRequest updateMemberInfoWithNickName:nickName withMemberName:memberName withMemberSex:memberSex withMemberMarry:memberMarry withMemberBirthday:memberBirthday withToken:token withBlock:^(NSDictionary *response, NSString *error) {
        if ([[response objectForKey:@"errorCode"] unsignedLongValue] == 0) {
            GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.memberName = memberName;
            [[NSUserDefaults standardUserDefaults] setObject:memberName forKey:@"memberName"];
            GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.memberNickName= nickName;
            [[NSUserDefaults standardUserDefaults] setObject:nickName forKey:@"memberNickName"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateMemberInfoSuccess" object:nil];
        }
    }];
}

- (void)updatePasswordWithToke:(NSString *)token withOldCode:(NSString *)oldCode withNewCode:(NSString *)newCode wihhUpdateType:(int)type {
    [PersonalPesRequest updatePasswordWithToke:token withOldCode:oldCode withNewCode:newCode wihhUpdateType:type withBlock:^(NSDictionary *response, NSString *error) {
        if ([[response objectForKey:@"errorCode"] unsignedLongValue] == 0) {
            GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.memberPwd = newCode;
            [[NSUserDefaults standardUserDefaults] setObject:newCode forKey:@"memberPwd"];
        }
    }];
}

- (void)queryCollectGoodsInfo {
    [PersonalPesRequest queryCollectGoodsInfoWithMemberId:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.memberId withBlock:^(NSDictionary *response, NSString *error) {
        if ([[response objectForKey:@"errorCode"] unsignedLongValue]== 0) {
            if (![[response objectForKey:@"data"] isKindOfClass:[NSString class]]) {
                NSArray *array = [response objectForKey:@"data"];
                for (NSDictionary *dict in array) {
                    CollectGoodsInfo *info = [[CollectGoodsInfo alloc] init];
                    info.colletDate = [dict objectForKey:@"collectionDate"];
                    info.collectId = [[dict objectForKey:@"collectionId"] unsignedLongValue];
                    NSDictionary *subDict = [dict objectForKey:@"goodsInfo"];
                    info.goodsName = [subDict objectForKey:@"goodsName"];
                    info.goodsDate = [subDict objectForKey:@"goodsDate"];
                    info.goodsId = [[subDict objectForKey:@"goodsId"] unsignedLongValue];
                    info.goodsPic = [subDict objectForKey:@"goodsPic"];
                    info.goodsDetailPic = [subDict objectForKey:@"goodsDetail"];
                    info.goodsPrice = [[subDict objectForKey:@"goodsPrice"] unsignedLongValue];
                    info.goodsCount = [[subDict objectForKey:@"goodsCount"] unsignedLongValue];
                    [self.collectGoodsInfos addObject:info];
                }
            } else {
                //没数据
            }
        } else {
            //请求失败
        }
    }];
}

@end
