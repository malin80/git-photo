//
//  PesRequest.h
//  Photo
//
//  Created by malin  on 2017/7/28.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PesResponse.h"

@interface PesRequest : NSObject

+(instancetype)sharedInstance;

- (void)pesRequestWithFunctionName:(NSString *)string andParameter:(NSDictionary *)parameter;

@end
