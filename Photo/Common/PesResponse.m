//
//  PesResponse.m
//  Photo
//
//  Created by malin  on 2017/7/28.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "PesResponse.h"

@implementation PesResponse

+(instancetype)sharedInstance
{
    static id sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^ {
        sharedClient = [[PesResponse alloc]init];
    });
    return sharedClient;
}

- (void)pesResponseWithResponseObject:(NSDictionary *)responseObject {
    self.response = responseObject;
}

- (NSDictionary *)pesResponse {
    return self.response;
}

@end
