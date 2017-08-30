//
//  VideoPesRequest.m
//  Photo
//
//  Created by malin  on 2017/8/30.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "VideoPesRequest.h"

@implementation VideoPesRequest

+ (void)queryAllVideoAuthor:(void (^)(NSDictionary *, NSString *))finished {
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"VideoADAuthorControl/queryVideoADAuthor.do" dic:nil finished:finished];
}

@end
