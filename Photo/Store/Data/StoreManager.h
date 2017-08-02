//
//  StoreManager.h
//  Photo
//
//  Created by malin  on 2017/8/2.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreManager : NSObject

DECLARE_SINGLETON_FOR_CLASS(StoreManager)

@property (nonatomic, strong) NSMutableArray *goodsInfoArray;

@property (nonatomic, strong) NSMutableArray *goodsClassifyArray;

- (void)queryAllGoodsInfo;

- (void)queryGoodsClassify;


@end
