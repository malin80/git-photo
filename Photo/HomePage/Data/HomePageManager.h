//
//  HomePageManager.h
//  Photo
//
//  Created by malin  on 2017/8/1.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomePagePesRequest.h"

@interface HomePageManager : NSObject

DECLARE_SINGLETON_FOR_CLASS(HomePageManager)

@property (nonatomic, strong) NSMutableArray *scrollViewImages;
@property (nonatomic, strong) NSMutableArray *recommendImages;
@property (nonatomic, strong) NSMutableArray *singleRecommendImages;

- (void)loadScrollViewImages;

- (void)loadRecommendImages;

@end
