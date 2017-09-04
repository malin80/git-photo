//
//  VideoPesRequest.h
//  Photo
//
//  Created by malin  on 2017/8/30.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PesRequest.h"

@interface VideoPesRequest : NSObject

+ (void)queryAllVideoAuthor:(void(^)(NSDictionary *responseObject,NSString *error))finished;

+ (void)queryVideoAuthorDetailWithId:(long)authorId withBlock:(void(^)(NSDictionary *responseObject,NSString *error))finished;

@end
