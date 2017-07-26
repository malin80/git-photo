//
//  EntrySection.m
//  Photo
//
//  Created by malin  on 2017/7/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "EntrySection.h"

@implementation EntrySection

- (instancetype)init
{
    self = [super init];
    if (self) {
        _items = [[NSMutableArray<EntryItem *> alloc] init];
    }
    return self;
}

@end
