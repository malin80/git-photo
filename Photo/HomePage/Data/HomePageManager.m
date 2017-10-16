//
//  HomePageManager.m
//  Photo
//
//  Created by malin  on 2017/8/1.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "HomePageManager.h"
#import "ImageInfo.h"

@implementation HomePageManager

SYNTHESIZE_SINGLETON_FOR_CLASS(HomePageManager)

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scrollViewImages = [NSMutableArray array];
        self.recommendImages = [NSMutableArray array];
        self.singleRecommendImages = [NSMutableArray array];
    }
    return self;
}

- (void)loadScrollViewImages {
    [HomePagePesRequest loadPageScrollViewImage:^(NSDictionary *responseObject,NSString *error){
        if ([[responseObject objectForKey:@"errorCode"] unsignedLongValue] == 0) {
            NSArray *urlArray = [responseObject objectForKey:@"data"];
            for (NSDictionary *dict in urlArray) {
                ImageInfo *info = [[ImageInfo alloc] init];
                NSString *urlString = [dict objectForKey:@"homeSlideImgUrl"];
                NSInteger imageId = [[dict objectForKey:@"homeSlideId"] integerValue];
                info.imageUrl = urlString;
                info.imageId = imageId;
                NSDictionary *detailDict = [dict objectForKey:@"slideUrl"];
                info.imageType = [detailDict objectForKey:@"slideType"];
                info.cameraManId = [[detailDict objectForKey:@"cameramanId"] unsignedLongValue];
                info.dressManId = [[detailDict objectForKey:@"dresserId"] unsignedLongValue];
                info.imageSlideUrl = [detailDict objectForKey:@"slideUrlImg"];
                info.goodsId = [[detailDict objectForKey:@"goodsIds"] unsignedLongValue ];
                [self.scrollViewImages addObject:info];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"loadScrollViewImagesSuccess" object:nil];
            });
        }
    }];
}

- (void)loadRecommendImages {
    [HomePagePesRequest loadPageRecommendImages:^(NSDictionary *responseObject, NSString *error) {
        if ([[responseObject objectForKey:@"errorCode"] unsignedLongValue] == 0) {
            NSArray *array = [responseObject objectForKey:@"data"];
            for (NSDictionary *dict in array) {
                ImageInfo *info = [[ImageInfo alloc] init];
                info.imageUrl = [dict objectForKey:@"recommendSlideImgsUrl"];
                info.imageName = [dict objectForKey:@"recommendSlideName"];
                NSInteger imageId = [[dict objectForKey:@"recommendSlideId"] integerValue];
                info.imageId = imageId;
                NSArray *temp = [info.imageUrl componentsSeparatedByString:@";"];
                [self.singleRecommendImages addObject:temp];
                [self.recommendImages addObject:info];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"loadRecommendImagesSuccess" object:nil];
            });
        }
    }];
}

@end
