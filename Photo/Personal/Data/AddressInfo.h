//
//  AddressInfo.h
//  Photo
//
//  Created by malin  on 2017/8/9.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressInfo : NSObject

@property (nonatomic, assign) long status;
@property (nonatomic, assign) long addressId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *phone;

@end
