//
//  TableViewCellCalculator.m
//  Photo
//
//  Created by malin  on 2017/8/11.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "TableViewCellCalculator.h"

@interface TableViewCellCalculator ()

@property (strong, nonatomic, readonly) NSCache *cache;

@end

@implementation TableViewCellCalculator

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self defaultConfigure];
    }
    return self;
}

- (void)defaultConfigure
{
    NSCache *cache = [NSCache new];
    cache.name = @"ZHCellHeightCalculator.cache";
    cache.countLimit = 200;
    _cache = cache;
}

#pragma mark - NSObject

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: cache=%@",
            [self class], self.cache];
}

#pragma mark - Publci Methods
- (void)clearCaches
{
    [self.cache removeAllObjects];
}


- (void)setHeight:(CGFloat)height withCalculateheightModel:(GoodsInfo *)info
{
    NSAssert(info != nil, @"Cell Model can't  nil");
    NSAssert(height >= 0, @"cell height must greater than or equal to 0");
    
    [self.cache setObject:[NSNumber numberWithFloat:height] forKey:@(info.hash)];
}


- (CGFloat)heightForCalculateheightModel:(GoodsInfo *)info
{
    NSNumber *cellHeightNumber = [self.cache objectForKey:@(info.hash)];
    if (cellHeightNumber) {
        return [cellHeightNumber floatValue];
    } else
        return -1;
}

@end
