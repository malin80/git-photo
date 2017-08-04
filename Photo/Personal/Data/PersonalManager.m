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

@implementation PersonalManager
SYNTHESIZE_SINGLETON_FOR_CLASS(PersonalManager)

- (void)queryCollectGoodsInfo {
    [PersonalPesRequest queryCollectGoodsInfoWithMemberId:GET_SINGLETON_FOR_CLASS(LoginManager).memberInfo.memberId withBlock:^(NSDictionary *response, NSString *error) {
        
    }];
}

@end
