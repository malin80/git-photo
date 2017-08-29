//
//  FlowerManager.h
//  Photo
//
//  Created by malin  on 2017/8/29.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlowerManager : NSObject

DECLARE_SINGLETON_FOR_CLASS(FlowerManager)

@property (nonatomic, strong) NSMutableArray *flowerInfos;

- (void)queryAllFlower;

@end
