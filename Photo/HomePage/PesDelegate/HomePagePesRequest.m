//
//  HomePagePesRequest.m
//  Photo
//
//  Created by malin  on 2017/7/28.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "HomePagePesRequest.h"

@implementation HomePagePesRequest

+ (void)queryHonorInfo {
    NSString *functionName = @"TeamControl/selectAllTeam.do";
    
    [[PesRequest sharedInstance] pesRequestWithFunctionName:functionName andParameter:nil];
}

@end
