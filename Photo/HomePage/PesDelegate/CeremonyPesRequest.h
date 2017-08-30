//
//  CeremonyPesRequest.h
//  Photo
//
//  Created by malin  on 2017/8/30.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PesRequest.h"

@interface CeremonyPesRequest : NSObject

+ (void)queryAllCeremony:(void(^)(NSDictionary *responseObject,NSString *error))finished;

+ (void)queryCeremonyDetailWithId:(long)ceremonyId withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished;

@end
