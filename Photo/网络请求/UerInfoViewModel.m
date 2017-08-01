//
//  UerInfoViewModel.m
//  Xiufenqi2.0
//
//  Created by 不丕 on 16/10/13.
//  Copyright © 2016年 艾蒂尔文化传媒有限公司. All rights reserved.
//

#import "UerInfoViewModel.h"

@implementation UerInfoViewModel
//单例
+ (instancetype)sharedUserInfoViewModel{
    static UerInfoViewModel *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
#pragma mark 用户登录接口
- (void)loginUserPhone:(NSString *)phone valid:(NSString *)valid finished:(void(^)(id restuct,NSString *error))finished{
  
}
#pragma mark 发送短信验证
- (void)loginSendMessagePhone:(NSString *)phone finished:(void(^)(id restuct,NSString *error))finished{
    //NSString *mysign=[[NSString stringWithFormat:@"%@mymeifenpai",phone] md5];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         phone,@"phone",
                         nil];
    
    [[Networking sharedTools]presendUserNOPrefic:@"auth/send_phone_valid/login" parames:dic requestCallBack:^(id result, NSString *error, NSProgress *progress) {
        if (error) {
            finished(nil,error);
            return ;
        }
        
        if (result) {
            finished(result,nil);
        }
        
        
    }];
}

#pragma mark 首页页面滚动
- (void)FirstPageScroll:(void(^)(id restuct,NSString *error))finished{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
   
    [self netWorkApi:@"HomeSlideControl/queryHomeSlide.do" dic:dic finished:finished];
}

#pragma mark 网络返回
- (void)netWorkApi:(NSString *)api dic:(NSDictionary *)dic finished:(void(^)(id restuct,NSString *error))finished{
    
    [[Networking sharedTools]presendUserNOPrefic:api parames:dic requestCallBack:^(id result, NSString *error, NSProgress *progress) {
        if (error) {
            finished(nil,error);
            return ;
        }
        
        if (result) {
            finished(result,nil);
        }
        
    }];
}
@end
