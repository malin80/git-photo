//
//  ClothManager.h
//  Photo
//
//  Created by malin  on 2017/8/23.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ClothManager : NSObject

DECLARE_SINGLETON_FOR_CLASS(ClothManager)

@property (nonatomic, strong) NSMutableArray *clothTypes;
@property (nonatomic, strong) NSMutableArray *cloths;

- (void)queryClothTypes;

- (void)queryClothsWithTypeId:(long)typeId;

@end
