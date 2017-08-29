//
//  FlowerPesRequest.h
//  Photo
//
//  Created by malin  on 2017/8/29.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PesRequest.h"

@interface FlowerPesRequest : NSObject

+ (void)queryAllFlower:(void(^)(NSDictionary *responseObject,NSString *error))finished;

@end
