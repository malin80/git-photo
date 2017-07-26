//
//  EntryItem.m
//  Photo
//
//  Created by malin  on 2017/7/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "EntryItem.h"

@implementation EntryItem

- (instancetype)initWithIconName:(NSString *)iconName withTitle:(NSString *)title
{
    return [self initWithIconName:iconName withTitle:title];
}

+ (EntryItem *)iconName:(NSString *)iconName title:(NSString *)title selector:(SEL)selector
{
    return [[EntryItem alloc] initWithIconName:iconName withTitle:title withContent:nil withSubtitle:nil withSelector:selector];
}

+ (EntryItem *)title:(NSString *)title content:(NSString *)content subtitle:(NSString *)subtitle selector:(SEL)selector
{
    return [[EntryItem alloc] initWithIconName:nil withTitle:title withContent:content withSubtitle:subtitle withSelector:selector];
}

- (instancetype)initWithIconName:(NSString *)iconName
                       withTitle:(NSString *)title
                     withContent:(NSString *)content
                    withSubtitle:(NSString *)subtitle
                    withSelector:(SEL)selector
{
    self = [super init];
    if (self) {
        _icon = [UIImage imageNamed:iconName];
        _title = title;
        _content = content;
        _subtitle = subtitle;
        _selector = selector;
    }
    return self;
}

@end
