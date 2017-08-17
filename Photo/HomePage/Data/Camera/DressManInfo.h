//
//  DressManInfo.h
//  Photo
//
//  Created by malin  on 2017/8/10.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DressManInfo : NSObject

@property (nonatomic, strong) NSString *dressManPic;
@property (nonatomic, strong) NSString *dressManName;
@property (nonatomic, strong) NSString *dressManSynopsis;
@property (nonatomic, strong) NSString *dressManPwd;
@property (nonatomic, strong) NSString *dressManNum;
@property (nonatomic, strong) NSString *dressManContent;
@property (nonatomic, strong) NSString *dressManComment;
@property (nonatomic, assign) long dressManId;
@property (nonatomic, assign) long subscribeCount;
@property (nonatomic, assign) long commentCount;
@property (nonatomic, assign) long worksOfDressMan;

@property (nonatomic, strong) NSArray *worksList;
@property (nonatomic, strong) NSArray *commentList;
@property (nonatomic, strong) NSArray *scheduleList;

@end
