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

+ (void)updatePasswordWithToke:(NSString *)token withOldCode:(NSString *)oldCode withNewCode:(NSString *)newCode wihhUpdateType:(int)type withBlock:(void (^)(NSDictionary *response, NSString *error))finished;

+ (void)queryCollectGoodsInfoWithMemberId:(long)memberId withBlock:(void (^)(NSDictionary *response, NSString *error))finished;

+ (void)deleteCollectGoodsInfoWithColletId:(long)collectId withBlock:(void (^)(NSDictionary *response, NSString *error))finished;

+ (void)queryMemberAddressWithMemberId:(long)memberId withBlock:(void (^)(NSDictionary *response, NSString *error))finished;

+ (void)addMemberAddressWithName:(NSString *)name withPhone:(NSString *)phone withAddress:(NSString *)address withStatus:(long)status withMemberId:(long)memberId withBlock:(void (^)(NSDictionary *response, NSString *error))finished;

+ (void)updateMemberAddressWithName:(NSString *)name withPhone:(NSString *)phone withAddress:(NSString *)address withStatus:(long)status withAddressId:(long)addressId withBlock:(void (^)(NSDictionary *response, NSString *error))finished;

+ (void)deleteMembetAddressWithAddressId:(long)addressId withBlock:(void (^)(NSDictionary *response, NSString *error))finished;

+ (void)makeAddressDefaultWithAddressId:(long)addressId withBlock:(void (^)(NSDictionary *response, NSString *error))finished;

+ (void)cancelAddressDefaultWithAddressId:(long)addressId withBlock:(void (^)(NSDictionary *response, NSString *error))finished;

+ (void)queryMemberOrderGoodsInfoWithToken:(NSString *)token withBlock:(void (^)(NSDictionary *response, NSString *error))finished;

+ (void)cancelMemberOrderWithToken:(NSString *)token withOrderId:(long)orderId withBlock:(void (^)(NSDictionary *response, NSString *error))finished;

+ (void)backMemberOrderWithToken:(NSString *)token withOrderId:(long)orderId withBlock:(void (^)(NSDictionary *response, NSString *error))finished;

+ (void)deleteMemberOrderWithToken:(NSString *)token withOrderId:(long)orderId withBlock:(void (^)(NSDictionary *response, NSString *error))finished;

+ (void)updateAppWithBlock:(void (^)(NSDictionary *response, NSString *error))finished;

+ (void)updateMemberAvatarWithToken:(NSString *)token withUpfile:(NSData *)data withBlock:(void (^)(NSDictionary *response, NSString *error))finished;

+ (void)queryCameraManOrderInfoWithToken:(NSString *)token withBlock:(void (^)(NSDictionary *response, NSString *error))finished;

+ (void)cancelCameraManOrderInfoWithToken:(NSString *)token withOrderId:(long)orderId withBlock:(void (^)(NSDictionary *response, NSString *error))finished;

+ (void)deleteCameraManOrderInfoWithToken:(NSString *)token withOrderId:(long)orderId withBlock:(void (^)(NSDictionary *response, NSString *error))finished;

+ (void)backCameraManOrderInfoWithToken:(NSString *)token withOrderId:(long)orderId withBlock:(void (^)(NSDictionary *response, NSString *error))finished;


@end
