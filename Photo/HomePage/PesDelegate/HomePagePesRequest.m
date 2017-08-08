//
//  HomePagePesRequest.m
//  Photo
//
//  Created by malin  on 2017/7/28.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "HomePagePesRequest.h"

@implementation HomePagePesRequest

+ (void)loadPageScrollViewImage:(void(^)(NSDictionary *responseObject,NSString *error))finished {
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"HomeSlideControl/queryHomeSlide.do" dic:nil finished:finished];
}

+ (void)loadPageRecommendImages:(void (^)(NSDictionary *, NSString *))finished {
    [GET_SINGLETON_FOR_CLASS(PesRequest) requestWithFunctionName:@"RecommendSlideControl/queryRecommendSlide.do" dic:nil finished:finished];
}

@end
