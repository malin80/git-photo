//
//  CarPesRequest.h
//  Photo
//
//  Created by malin  on 2017/8/28.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PesRequest.h"

@interface CarPesRequest : NSObject

+ (void)queryAllCar:(void(^)(NSDictionary *responseObject,NSString *error))finished;


@end
