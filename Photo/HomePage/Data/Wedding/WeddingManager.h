//
//  WeddingManager.h
//  Photo
//
//  Created by malin  on 2017/8/17.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeddingManager : NSObject

DECLARE_SINGLETON_FOR_CLASS(WeddingManager)

@property (nonatomic, strong) NSMutableArray *bussinessInfos;
@property (nonatomic, strong) NSMutableArray *businessComments;

- (void)queryAllWeddingBusiness;

- (void)queryWeddingBusinessWithId:(long)businessId;

@end
