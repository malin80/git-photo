//
//  PersonalPesRequest.h
//  Photo
//
//  Created by malin  on 2017/8/1.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalPesRequest : NSObject

//MemberControl/updateMemberDetail.do(nickName,memberName,memberSex,memberMarry,memberBirthday,token)
+ (void)updateMemberInfoWithNickName:(NSString *)nickName withMemberName:(NSString *)memberName withMemberSex:(NSString *)memberSex withMemberMarry:(NSString *)memberMarry withMemberBirthday:(NSString *)memberBirthday withToken:(NSString *)token withBlock:(void (^)(NSDictionary *response, NSString *error))finished;

//	MemberControl/updateMemberPwd.do(token,oldCode,newCode,updateType)
//--updateType  0:根据原密码修改  1:根据验证码修改
//--oldCode  updateType=0时为原密码  updateType=1时为验证码
//--newCode  新密码
+ (void)updatePasswordWithToke:(NSString *)token withOldCode:(NSString *)oldCode withNewCode:(NSString *)newCode wihhUpdateType:(int)type withBlock:(void (^)(NSDictionary *response, NSString *error))finished;

+ (void)queryCollectGoodsInfoWithMemberId:(long)memberId withBlock:(void (^)(NSDictionary *response, NSString *error))finished;

@end
