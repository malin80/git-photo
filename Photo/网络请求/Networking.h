//
//  Networking.h
//  Xiufenqi2.0
//
//  Created by 不丕 on 16/10/13.
//  Copyright © 2016年 艾蒂尔文化传媒有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "AFHTTPSessionManager.h"
typedef enum {
    RequestMethodGET = 0,
    RequestMethodPOST,
}RequestMethod;
typedef void(^RequestCallBack)(id result,NSString * error, NSProgress * progress);
@interface Networking : AFHTTPSessionManager
// 单例
+ (instancetype)sharedTools;

//提交各种账号接口
- (void)presendUserNOPrefic:(NSString *)prefic parames:(NSDictionary *)parames requestCallBack:(RequestCallBack)block;
@end
