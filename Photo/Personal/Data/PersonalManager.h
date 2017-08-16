//
//  PersonalManager.h
//  Photo
//
//  Created by malin  on 2017/8/4.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressInfo.h"

@interface PersonalManager : NSObject
DECLARE_SINGLETON_FOR_CLASS(PersonalManager)

@property (nonatomic, strong) NSMutableArray *collectGoodsInfos;
@property (nonatomic, strong) NSMutableArray *addressInfos;
@property (nonatomic, strong) AddressInfo *normalAddressInfo;
@property (nonatomic, strong) NSMutableArray *orderGoodsInfos;
@property (nonatomic, strong) NSMutableArray *cameraManOrderInfos;

//更新用户信息
- (void)updateMemberInfoWithNickName:(NSString *)nickName
                      withMemberName:(NSString *)memberName
                       withMemberSex:(NSString *)memberSex
                     withMemberMarry:(NSString *)memberMarry
                  withMemberBirthday:(NSString *)memberBirthday
                           withToken:(NSString *)token;

//更新密码
- (void)updatePasswordWithToke:(NSString *)token withOldCode:(NSString *)oldCode withNewCode:(NSString *)newCode wihhUpdateType:(int)type;

//收藏相关
- (void)queryCollectGoodsInfo;

- (void)deleteCollectGoodsInfoWithCollectId:(long)collectId;

//地址相关
- (void)queryMemberAddressWithMemberId:(long)memberId;

- (void)addMemberAddressWithName:(NSString *)name withPhone:(NSString *)phone withAddress:(NSString *)address withStatus:(long)status withMemberId:(long)memberId;

- (void)updateMemberAddressWithName:(NSString *)name withPhone:(NSString *)phone withAddress:(NSString *)address withStatus:(long)status withAddressId:(long)addressId;

- (void)deleteMemberAddressWithAddressId:(long)addressId;

- (void)makeAddressDefaultWithAddressId:(long)addressId;

- (void)cancelAddressDefaultWithAddressId:(long)addressId;

//订单相关
//商品订单
- (void)queryMemberOrderGoodsInfoWithToken:(NSString *)token;   //查询所有商品订单
- (void)cancelMemberOrderGoodsInfoWithToken:(NSString *)token withOrderId:(long)orderId; //取消订单
- (void)backMemberOrderGoodsInfoWithToken:(NSString *)token withOrderId:(long)orderId; //申请退单
- (void)deleteMemberOrderGoodsInfoWithToken:(NSString *)token withOrderId:(long)orderId; //删除订单

//预约订单
- (void)queryCameraManOrderInfoWithToken:(NSString *)token;         //摄影师预约订单
- (void)cancelCameraManOrderInfoWithToken:(NSString *)token withOrderId:(long)orderId;  //取消订单
- (void)backCameraManOrderInfoWithToken:(NSString *)token withOrderId:(long)orderId;    //申请退单
- (void)deleteCameraManOrderInfoWithToken:(NSString *)token withOrderId:(long)orderId;  //删除订单

//更新app
- (void)updateApp;

//上传头像
- (void)updateMemberAvatarWithToken:(NSString *)token withUpFile:(NSData *)data;

@end
