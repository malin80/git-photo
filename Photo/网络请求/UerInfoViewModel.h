//
//  UerInfoViewModel.h
//  Xiufenqi2.0
//
//  Created by 不丕 on 16/10/13.
//  Copyright © 2016年 艾蒂尔文化传媒有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Networking.h"
@interface UerInfoViewModel : NSObject
typedef void(^RequestCallBack)(id result,NSString * error, NSProgress * progress);
typedef void(^UploadFileCallBack)(NSURLResponse *response, id  responseObject, NSError *error,NSProgress * progress);
typedef void(^RequestCallBack)(id result,NSString *error, NSProgress *progress);
// 单例
+ (instancetype)sharedUserInfoViewModel;
//登录接口
- (void)loginUserPhone:(NSString *)phone valid:(NSString *)valid finished:(void(^)(id restuct,NSString *error))finished;
//首页页面滚动
- (void)FirstPageScroll:(void(^)(id restuct,NSString *error))finished;
//发送短信验证
- (void)loginSendMessagePhone:(NSString *)phone finished:(void(^)(id restuct,NSString *error))finished;

@end
