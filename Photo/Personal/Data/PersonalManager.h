//
//  PersonalManager.h
//  Photo
//
//  Created by malin  on 2017/8/4.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalManager : NSObject
DECLARE_SINGLETON_FOR_CLASS(PersonalManager)

- (void)queryCollectGoodsInfo;

@end
