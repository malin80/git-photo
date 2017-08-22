//
//  WeddingBusinessInfo.h
//  Photo
//
//  Created by malin  on 2017/8/17.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeddingBusinessInfo : NSObject

@property (nonatomic, copy) NSString *businessName;
@property (nonatomic, copy) NSString *businessAddress;
@property (nonatomic, copy) NSString *businessPic;
@property (nonatomic, copy) NSString *businessSubText1;
@property (nonatomic, copy) NSString *businessSubText2;
@property (nonatomic, copy) NSString *businessGrade;
@property (nonatomic, copy) NSString *businessPhone;
@property (nonatomic, copy) NSString *businessScrollPic;
@property (nonatomic, copy) NSString *businessIntroduction;

@property (nonatomic, assign) long businessPrice;
@property (nonatomic, assign) long businessStarCount;
@property (nonatomic, assign) long businessId;
@property (nonatomic, assign) long businessCommentCount;
@property (nonatomic, assign) long businessCaseCount;
@property (nonatomic, assign) long businessTypeCount;

@property (nonatomic, assign) long businessCaseId;
@property (nonatomic, assign) long businessCasePrice;
@property (nonatomic, assign) long businessTypeId;
@property (nonatomic, assign) long businessCaseBrowser;
@property (nonatomic, assign) long businessTypeSoldNumber;

@property (nonatomic, copy) NSString *businessCasePic;
@property (nonatomic, copy) NSString *businessTypeName;
@property (nonatomic, copy) NSString *businessTypeStyle;

@property (nonatomic, copy) NSString *businessTypeDetailDes;
@property (nonatomic, copy) NSString *businessTypeDetailName;
@property (nonatomic, copy) NSString *businessTypeDetailPic;

@end
