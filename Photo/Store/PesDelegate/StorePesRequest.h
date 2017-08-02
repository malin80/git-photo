//
//  StorePesRequest.h
//  Photo
//
//  Created by malin  on 2017/8/2.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PesRequest.h"

@interface StorePesRequest : NSObject

+ (void)queryAllGoodsInfo:(void(^)(NSDictionary *responseObject,NSString *error))finished;

@end
