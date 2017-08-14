//
//  SDWebImageCache.h
//  Photo
//
//  Created by malin  on 2017/8/14.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDWebImageCache : NSObject

+ (void)getImageFromSDWebImageWithUrlString:(NSString *)urlString completed:(SDWebImageCompletionWithFinishedBlock)completedBlock;

@end
