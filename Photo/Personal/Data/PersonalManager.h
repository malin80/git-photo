//
//  PersonalManager.h
//  Photo
//
//  Created by malin  on 2017/8/4.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalManager : NSObject
DECLARE_SINGLETON_FOR_CLASS(PersonalManager)

@property (nonatomic, strong) NSMutableArray *collectGoodsInfos;

- (void)updateMemberInfoWithNickName:(NSString *)nickName
                      withMemberName:(NSString *)memberName
                       withMemberSex:(NSString *)memberSex
                     withMemberMarry:(NSString *)memberMarry
                  withMemberBirthday:(NSString *)memberBirthday
                           withToken:(NSString *)token;

- (void)updatePasswordWithToke:(NSString *)token withOldCode:(NSString *)oldCode withNewCode:(NSString *)newCode wihhUpdateType:(int)type;


- (void)queryCollectGoodsInfo;

@end
