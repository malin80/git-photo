//
//  SDWebImageCache.m
//  Photo
//
//  Created by malin  on 2017/8/14.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "SDWebImageCache.h"
#import "SDWebImageManager.h"

@implementation SDWebImageCache

+ (void)getImageFromSDWebImageWithUrlString:(NSString *)urlString completed:(SDWebImageCompletionWithFinishedBlock)completedBlock
{
    NSURL *url = [NSURL URLWithString:urlString];
    if (!url) {
        return;
    }
    SDWebImageManager *manager = [self imageManager];
    [manager downloadImageWithURL:url options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        completedBlock(image, error, cacheType, finished, imageURL);
    }];
}

+ (id)imageManager
{
    static dispatch_once_t imageManagerOnce;
    static id imageManagerInstance;
    static const NSInteger kImageCacheMaxCacheAge = 60 * 60 * 24 * 30; // 30 day
    dispatch_once(&imageManagerOnce, ^{
        imageManagerInstance = [[SDWebImageManager alloc] init];
    });
    return imageManagerInstance;
}

@end
