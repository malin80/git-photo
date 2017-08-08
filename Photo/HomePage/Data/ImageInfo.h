//
//  ImageInfo.h
//  Photo
//
//  Created by malin  on 2017/8/8.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageInfo : NSObject

@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, assign) NSInteger *imageId;
@property (nonatomic, copy) NSString *imageName;

@end
