//
//  PesRequest.m
//  Photo
//
//  Created by malin  on 2017/7/28.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "PesRequest.h"
#import <AFNetworking.h>

@implementation PesRequest


+(instancetype)sharedInstance
{
    static id sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^ {
          sharedClient = [[PesRequest alloc]init];
      });
    return sharedClient;
}

- (void)pesRequestWithFunctionName:(NSString *)string andParameter:(NSDictionary *)parameter {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    NSString *urlString = [NSString stringWithFormat:@"http://101.201.122.173/%@",string];
    [manager GET:urlString parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        [[PesResponse sharedInstance] pesResponseWithResponseObject:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

@end
