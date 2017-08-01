//
//  HomePagePesRequest.m
//  Photo
//
//  Created by malin  on 2017/7/28.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "HomePagePesRequest.h"

@implementation HomePagePesRequest

+ (void)loadPageScrollViewImage:(void(^)(id restuct,NSString *error))finished {
    [[PesRequest sharedInstance] netWorkApi:@"HomeSlideControl/queryHomeSlide.do" dic:nil finished:finished];
}

@end
