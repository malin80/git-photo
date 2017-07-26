//
//  EntrySection.h
//  Photo
//
//  Created by malin  on 2017/7/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntryItem.h"

@interface EntrySection : NSObject

@property (nonatomic, strong) NSMutableArray<EntryItem *> *items;

@end
