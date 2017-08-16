//
//  PesRequest.m
//  Photo
//
//  Created by malin  on 2017/7/28.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "PesRequest.h"

@implementation PesRequest

SYNTHESIZE_SINGLETON_FOR_CLASS(PesRequest)


- (void)pesRequestWithFunctionName:(NSString *)functionName withParameter:(NSDictionary *)parameter requestCallBack:(RequestCallBack)block {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameter];
    [self requestWithMethod:RequestMethodPOST urlString:functionName parames:dic finished:block];
    NSLog(@"functionName = %@",functionName);
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
        [self GET:urlString parameters:parames progress:nil success:successback failure:failureback];
    } else {
        [self POST:url parameters:parames progress:nil success:successback failure:failureback];
    }
}

#pragma mark 网络返回
- (void)requestWithFunctionName:(NSString *)functionName dic:(NSDictionary *)dic finished:(void(^)(NSDictionary *responseObject,NSString *error))finished {
    [self pesRequestWithFunctionName:functionName withParameter:dic requestCallBack:^(id result, NSString *error, NSProgress *progress) {
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
