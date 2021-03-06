//
//  ClothPesRequest.h
//  Photo
//
//  Created by malin  on 2017/8/23.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PesRequest.h"

@interface ClothPesRequest : NSObject

+ (void)queryClothType:(void(^)(NSDictionary *responseObject,NSString *error))finished;

+ (void)queryClothsWithTypeId:(long)typeId withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished;

+ (void)queryClothDetailWithClothId:(long)clothId withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished;

+ (void)buyClothWithToken:(NSString *)token withClothId:(long)clothId withClothCount:(long)count withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished;

+ (void)queryClothOrderWithToken:(NSString *)token withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished;

@end
