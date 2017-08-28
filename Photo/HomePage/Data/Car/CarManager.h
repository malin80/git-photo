//
//  CarManager.h
//  Photo
//
//  Created by malin  on 2017/8/28.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarManager : NSObject

DECLARE_SINGLETON_FOR_CLASS(CarManager)

@property (nonatomic, strong) NSMutableArray *carInfos;

- (void)queryAllCar;

@end
