//
//  CeremonyInfo.h
//  Photo
//
//  Created by malin  on 2017/8/30.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CeremonyInfo : NSObject

@property (nonatomic, copy) NSString *ceremonyName;
@property (nonatomic, copy) NSString *ceremonySex;
@property (nonatomic, copy) NSString *ceremonyPic;
@property (nonatomic, copy) NSString *ceremonyPhone;
@property (nonatomic, copy) NSString *ceremonySigh;
@property (nonatomic, copy) NSString *ceremonySynopsis;

@property (nonatomic, assign) long ceremonyId;

@end
