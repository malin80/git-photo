//
//  ShoppingManager.h
//  Photo
//
//  Created by malin  on 2017/8/4.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingManager : NSObject

DECLARE_SINGLETON_FOR_CLASS(ShoppingManager)

@property (nonatomic, strong) NSMutableArray *shoppingGoodsInfos;

- (void)queryShoppingGoodsInfoWithSafeCodeValue:(NSString *)value;

- (void)deleteShoppingGoodsInfoWithCartId:(long)cartId withToken:(NSString *)token;

@end
