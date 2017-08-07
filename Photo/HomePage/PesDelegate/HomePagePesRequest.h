//
//  HomePagePesRequest.h
//  Photo
//
//  Created by malin  on 2017/7/28.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PesRequest.h"

@interface HomePagePesRequest : NSObject

+ (void)loadPageScrollViewImage:(void(^)(NSDictionary *responseObject,NSString *error))finished;

+ (void)queryCameraGroup:(void(^)(NSDictionary *responseObject,NSString *error))finished;

+ (void)queryCameraTeamWithGroupId:(long)groupId withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished;

+ (void)queryCarmeraManWithTeamId:(long)teamId withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished;

@end
