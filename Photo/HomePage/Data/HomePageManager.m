//
//  HomePageManager.m
//  Photo
//
//  Created by malin  on 2017/8/1.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "HomePageManager.h"
#import "HomePageScrollViewInfo.h"

@implementation HomePageManager

SYNTHESIZE_SINGLETON_FOR_CLASS(HomePageManager)

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scrollViewImages = [NSMutableArray array];
    }
    return self;
}

- (void)loadScrollViewImages {
    [HomePagePesRequest loadPageScrollViewImage:^(NSDictionary *responseObject,NSString *error){
        NSArray *urlArray = [responseObject objectForKey:@"data"];
        for (NSDictionary *dict in urlArray) {
            HomePageScrollViewInfo *info = [[HomePageScrollViewInfo alloc] init];
            NSString *urlString = [dict objectForKey:@"homeSlideImgUrl"];
            NSInteger imageId = [[dict objectForKey:@"homeSlideId"] integerValue];
            info.imageUrl = urlString;
            info.imageId = &(imageId);
            [self.scrollViewImages addObject:info];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loadScrollViewImagesSuccess" object:nil];
    }];
}


@end
