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

+ (void)loadPageScrollViewImage:(void(^)(id restuct,NSString *error))finished;

@end
