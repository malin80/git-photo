//
//  Networking.m
//  Xiufenqi2.0
//
//  Created by 不丕 on 16/10/13.
//  Copyright © 2016年 艾蒂尔文化传媒有限公司. All rights reserved.
//

#import "Networking.h"

@implementation Networking
//单例
+ (instancetype)sharedTools{
    static Networking *instance ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html", @"application/javascript",nil];
    });
    return instance;
}

//提交各种账号接口
- (void)presendUserNOPrefic:(NSString *)prefic parames:(NSDictionary *)parames requestCallBack:(RequestCallBack)block{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parames];
    //    [dic setObject:[self loadsaveSessData] forKey:@"app_sess"];
    //    [dic setValue:[SvUDIDTools UDID] forKey:@"device_code"];
    //    NSLog(@"%@",dic);
    [self requestWithMethod:RequestMethodPOST urlString:prefic parames:dic finished:block];
}
#pragma mark - AFN 网络封装
- (void)requestWithMethod:(RequestMethod)method urlString:(NSString *)urlString parames:(NSDictionary *)parames finished:(RequestCallBack)finished {
    NSString *url= [baseUrl stringByAppendingString:urlString];

    
    
    void (^successback)(NSURLSessionDataTask *, id ) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull result){
        //        LogString(result);
        finished(result,nil,nil);
        
        
    };
    //失败回调
    void (^failureback)(NSURLSessionDataTask *, NSError *) = ^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error){
        NSString *errorData = [NSString string];
        if (!error.userInfo[@"NSLocalizedDescription"]) {
            errorData = @"哎呀出错了";
        }else{
            errorData = error.userInfo[@"NSLocalizedDescription"];
        }
        finished(nil, errorData,nil);
        
    };
    if(method == RequestMethodGET) {
        //        [[NetWorkingTool sharedTools]GET:url parameters:parames progress:progress success:successback failure:failureback];
        [[Networking sharedTools] GET:url parameters:parames success:successback failure:failureback];
    } else {
        [[Networking sharedTools] POST:url parameters:parames success:successback failure:failureback];
    }
    
}
//获取便好设置数据
- (NSString *)loadsaveSessData{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"app_sess"];
}

@end
