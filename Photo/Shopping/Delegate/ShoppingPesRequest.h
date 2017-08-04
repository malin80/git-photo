//
//  ShoppingPesRequest.h
//  Photo
//
//  Created by malin  on 2017/8/3.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PesRequest.h"

@interface ShoppingPesRequest : NSObject

+ (void)queryShoppingGoodsInfoWithSafeCodeValue:(NSString *)safeCodeValue withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished;

@end
