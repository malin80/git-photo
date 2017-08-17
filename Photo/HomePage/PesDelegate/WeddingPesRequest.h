//
//  WeddingPesRequest.h
//  Photo
//
//  Created by malin  on 2017/8/17.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PesRequest.h"

@interface WeddingPesRequest : NSObject

+ (void)queryAllWeddingBusiness:(void(^)(NSDictionary *responseObject,NSString *error))finished;

+ (void)queryWeddingBusinessWithId:(long)businessId withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished;;

@end
