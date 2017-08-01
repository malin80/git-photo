//
//  HomePageManager.m
//  Photo
//
//  Created by malin  on 2017/8/1.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "HomePageManager.h"

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
    [HomePagePesRequest loadPageScrollViewImage:^(id restuct,NSString *error){
        NSArray *urlArray = [restuct objectForKey:@"data"];
        for (NSDictionary *dict in urlArray) {
            NSString *urlString = [dict objectForKey:@"homeSlideImgUrl"];
            [self.scrollViewImages addObject:urlString];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loadScrollViewImagesSuccess" object:nil];
    }];
}


@end
