//
//  PesRequest.h
//  Photo
//
//  Created by malin  on 2017/7/28.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "AFHTTPSessionManager.h"

typedef NS_ENUM(NSInteger, RequestMethod) {
    RequestMethodGET = 0,
    RequestMethodPOST,
};


typedef void(^RequestCallBack)(id result,NSString * error, NSProgress * progress);

@interface PesRequest : AFHTTPSessionManager

//单例
+ (instancetype)sharedInstance;

//提交各种账号接口
- (void)pesRequestWithFunctionName:(NSString *)functionName withParameter:(NSDictionary *)parameter requestCallBack:(RequestCallBack)block;

- (void)netWorkApi:(NSString *)api dic:(NSDictionary *)dic finished:(void(^)(id restuct,NSString *error))finished;


@end
