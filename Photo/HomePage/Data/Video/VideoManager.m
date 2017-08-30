//
//  VideoManager.m
//  Photo
//
//  Created by malin  on 2017/8/30.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "VideoManager.h"
#import "VideoPesRequest.h"

@implementation VideoManager

SYNTHESIZE_SINGLETON_FOR_CLASS(VideoManager)


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.videoAuthors = [NSMutableArray array];
    }
    return self;
}

- (void)queryAllVideoAuthor {
    [VideoPesRequest queryAllVideoAuthor:^(NSDictionary *responseObject, NSString *error) {
        if ([[responseObject objectForKey:@"errorCode"] unsignedLongValue] == 0) {
            [self.videoAuthors removeAllObjects];
            NSArray *array = [responseObject objectForKey:@"data"];
            for (NSDictionary *dict in array) {
                VideoAuthorInfo *info = [[VideoAuthorInfo alloc] init];
                info.authorName = [dict objectForKey:@"videoADAuthorName"];
                info.authorSign = [dict objectForKey:@"videoADAuthorSign"];
                info.authorSynopsis = [dict objectForKey:@"videoADAuthorSynopsis"];
                info.authorPic = [dict objectForKey:@"videoADAuthorHeadImg"];
                info.authorId = [[dict objectForKey:@"videoADAuthorId"] unsignedLongValue];
                [self.videoAuthors addObject:info];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"queryAllVideoAuthorSuccess" object:nil];
        }
    }];
}

@end
