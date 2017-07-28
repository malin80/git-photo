//
//  PesResponse.h
//  Photo
//
//  Created by malin  on 2017/7/28.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PesResponse : NSObject

+ (instancetype)sharedInstance;

- (void)pesResponseWithResponseObject:(NSDictionary *)responseObject;
- (NSDictionary *)pesResponse;

@property (nonatomic, strong) NSDictionary *response;

@end
