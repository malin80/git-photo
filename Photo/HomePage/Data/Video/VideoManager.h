//
//  VideoManager.h
//  Photo
//
//  Created by malin  on 2017/8/30.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoAuthorInfo.h"
#import "VideoWorkInfo.h"

@interface VideoManager : NSObject

DECLARE_SINGLETON_FOR_CLASS(VideoManager)

@property (nonatomic, strong) NSMutableArray *videoAuthors;
@property (nonatomic, strong) NSMutableArray *videoWorkInfos;
@property (nonatomic, strong) VideoAuthorInfo *authorInfo;

- (void)queryAllVideoAuthor;

- (void)queryVideoAuthorDetailWithId:(long)authorId;

@end
