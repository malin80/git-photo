//
//  ShoppingManager.m
//  Photo
//
//  Created by malin  on 2017/8/4.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "ShoppingManager.h"
#import "ShoppingPesRequest.h"

@implementation ShoppingManager

SYNTHESIZE_SINGLETON_FOR_CLASS(ShoppingManager)

- (void)queryShoppingGoodsInfoWithSafeCodeValue:(NSString *)value {
    [ShoppingPesRequest queryShoppingGoodsInfoWithSafeCodeValue:value withBlock:^(NSDictionary *responseObject, NSString *error) {
        
    }];
}

@end
