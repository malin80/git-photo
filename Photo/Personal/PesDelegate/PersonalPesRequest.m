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

+ (void)deleteCollectGoodsInfoWithColletId:(long)collectId withBlock:(void (^)(NSDictionary *response, NSString *error))finished {
    NSDictionary *dict = @{@"collectionId":@(collectId)};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"CollectionInfoControl/deleteCollectionInfo.do" dic:dict finished:finished];
}

+ (void)queryMemberAddressWithMemberId:(long)memberId withBlock:(void (^)(NSDictionary *, NSString *))finished {
    NSDictionary *dict = @{@"memberId":@(memberId)};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"DeliveryControl/queryDelivery.do" dic:dict finished:finished];
}

+ (void)addMemberAddressWithName:(NSString *)name
                       withPhone:(NSString *)phone
                     withAddress:(NSString *)address
                      withStatus:(long)status
                    withMemberId:(long)memberId
                       withBlock:(void (^)(NSDictionary *response, NSString *error))finished {
    NSDictionary *dict = @{@"deliveryName":name, @"deliveryAddress":address, @"deliveryPhone":phone, @"deliveryStatus":@(status), @"memberId":@(memberId)};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"DeliveryControl/saveDelivery.do" dic:dict finished:finished];
}

+ (void)updateMemberAddressWithName:(NSString *)name withPhone:(NSString *)phone withAddress:(NSString *)address withStatus:(long)status withAddressId:(long)addressId withBlock:(void (^)(NSDictionary *response, NSString *error))finished {
    NSDictionary *dict = @{@"deliveryName":name, @"deliveryAddress":address, @"deliveryPhone":phone, @"deliveryStatus":@(status), @"deliveryId":@(addressId)};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"DeliveryControl/updateDelivery.do" dic:dict finished:finished];
}

+ (void)deleteMembetAddressWithAddressId:(long)addressId withBlock:(void (^)(NSDictionary *, NSString *))finished {
    NSDictionary *dict = @{@"deliveryId":@(addressId)};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"DeliveryControl/deleteDelivery.do" dic:dict finished:finished];
}

+ (void)makeAddressDefaultWithAddressId:(long)addressId withBlock:(void (^)(NSDictionary *, NSString *))finished {
    NSDictionary *dict = @{@"deliveryId":@(addressId)};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"DeliveryControl/updateDeliveryStatus.do" dic:dict finished:finished];
}

+ (void)cancelAddressDefaultWithAddressId:(long)addressId withBlock:(void (^)(NSDictionary *, NSString *))finished {
    NSDictionary *dict = @{@"deliveryId":@(addressId)};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"DeliveryControl/cancleDeliveryStatus.do" dic:dict finished:finished];
}

+ (void)queryMemberOrderGoodsInfoWithToken:(NSString *)token withBlock:(void (^)(NSDictionary *, NSString *))finished {
    NSDictionary *dict = @{@"token":token};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"OrderOfGoodsDetailControl/queryOrderOfGoods.do" dic:dict finished:finished];
}

+ (void)cancelMemberOrderWithToken:(NSString *)token withOrderId:(long)orderId withBlock:(void (^)(NSDictionary *, NSString *))finished {
    NSDictionary *dict = @{@"token":token, @"orderOfGoodsDetailId":@(orderId)};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"OrderOfGoodsDetailControl/cancleOrderOfGoods.do" dic:dict finished:finished];
}

+ (void)backMemberOrderWithToken:(NSString *)token withOrderId:(long)orderId withBlock:(void (^)(NSDictionary *, NSString *))finished {
    NSDictionary *dict = @{@"token":token, @"orderOfGoodsDetailId":@(orderId)};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"OrderOfGoodsDetailControl/applyOrderOfGoods.do" dic:dict finished:finished];
}

+ (void)deleteMemberOrderWithToken:(NSString *)token withOrderId:(long)orderId withBlock:(void (^)(NSDictionary *, NSString *))finished {
    NSDictionary *dict = @{@"token":token, @"orderOfGoodsDetailId":@(orderId)};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"OrderOfGoodsDetailControl/removeOrderOfGoods.do" dic:dict finished:finished];
}

+ (void)updateAppWithBlock:(void (^)(NSDictionary *, NSString *))finished {
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"MarryVersionControl/queryMarryVersion.do" dic:nil finished:finished];
}

+ (void)updateMemberAvatarWithToken:(NSString *)token withUpfile:(NSData *)data withBlock:(void (^)(NSDictionary *, NSString *))finished {
    NSDictionary*dict = @{@"token":token, @"upfile":data};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"MemberControl/updateMemberPic.do" dic:dict finished:finished];
}

+ (void)queryCameraManOrderInfoWithToken:(NSString *)token withBlock:(void (^)(NSDictionary *, NSString *))finished {
    NSDictionary *dict = @{@"token":token};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"OrderInfoControl/queryOrderInfo.do" dic:dict finished:finished];
}

+ (void)cancelCameraManOrderInfoWithToken:(NSString *)token withOrderId:(long)orderId withBlock:(void (^)(NSDictionary *, NSString *))finished {
    NSDictionary *dict = @{@"token":token, @"orderInfoId":@(orderId)};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"OrderInfoControl/cancleOrderInfo.do" dic:dict finished:finished];
}

+ (void)backCameraManOrderInfoWithToken:(NSString *)token withOrderId:(long)orderId withBlock:(void (^)(NSDictionary *, NSString *))finished {
    NSDictionary *dict = @{@"token":token, @"orderInfoId":@(orderId)};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"OrderInfoControl/applyOrderInfo.do" dic:dict finished:finished];
}

+ (void)deleteCameraManOrderInfoWithToken:(NSString *)token withOrderId:(long)orderId withBlock:(void (^)(NSDictionary *, NSString *))finished {
    NSDictionary *dict = @{@"token":token, @"orderInfoId":@(orderId)};
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"OrderInfoControl/deleteOrderInfo.do" dic:dict finished:finished];
}

@end
