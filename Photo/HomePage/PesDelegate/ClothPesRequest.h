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

@end
