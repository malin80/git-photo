//
//  CeremonyManager.h
//  Photo
//
//  Created by malin  on 2017/8/30.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CeremonyInfo.h"

@interface CeremonyManager : NSObject

DECLARE_SINGLETON_FOR_CLASS(CeremonyManager)

@property (nonatomic, strong) NSMutableArray *ceremonyManInfos;
@property (nonatomic, strong) NSMutableArray *ceremonyWomenInfos;
@property (nonatomic, strong) NSMutableArray *ceremonyWorkInfos;
@property (nonatomic, strong) CeremonyInfo *ceremonyInfo;

- (void)queryAllCeremony;

- (void)queryCeremonyDetailWithId:(long)ceremonyId;

@end
