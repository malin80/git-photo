//
//  VideoAuthorInfo.h
//  Photo
//
//  Created by malin  on 2017/8/30.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoAuthorInfo : NSObject

@property (nonatomic, copy) NSString *authorName;
@property (nonatomic, copy) NSString *authorSign;
@property (nonatomic, copy) NSString *authorSynopsis;
@property (nonatomic, copy) NSString *authorPic;

@property (nonatomic, assign) long authorId;

@end
