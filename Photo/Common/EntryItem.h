//
//  EntryItem.h
//  Photo
//
//  Created by malin  on 2017/7/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EntryItem : NSObject

@property (nonatomic ,strong) UIImage *icon;
@property (nonatomic ,strong) NSString *title;
@property (nonatomic ,strong) NSString *content;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic) SEL selector;

- (instancetype)initWithIconName:(NSString *)iconName withTitle:(NSString *)title;

+ (EntryItem *)iconName:(NSString *)iconName title:(NSString *)title selector:(SEL)selector;

+ (EntryItem *)title:(NSString *)title content:(NSString *)content subtitle:(NSString *)subtitle selector:(SEL)selector;

@end
