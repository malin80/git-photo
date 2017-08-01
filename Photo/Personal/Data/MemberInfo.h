//
//  MemberInfo.h
//  Photo
//
//  Created by malin  on 2017/8/1.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemberInfo : NSObject

@property (nonatomic, assign) long memberId;
@property (nonatomic, copy) NSString *memberNickName;
@property (nonatomic, copy) NSString *memberName;
@property (nonatomic, copy) NSString *memberPwd;
@property (nonatomic, copy) NSString *memberPhone;
@property (nonatomic, assign) NSInteger memberSex;
@property (nonatomic, copy) NSString *memberPic;
@property (nonatomic, copy) NSString *safeCodeValue;
@property (nonatomic, copy) NSString *memberBirthday;
@property (nonatomic, copy) NSString *memberMarry;

@end
