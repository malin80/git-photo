//
//  TableViewCellCalculator.h
//  Photo
//
//  Created by malin  on 2017/8/11.
//  Copyright © 2017年 malin . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsInfo.h"

@interface TableViewCellCalculator : NSObject
//系统计算高度后缓存进cache
- (void)setHeight:(CGFloat)height withCalculateheightModel:(GoodsInfo *)info;

//根据model hash 获取cache中的高度,如过无则返回－1
- (CGFloat)heightForCalculateheightModel:(GoodsInfo *)info;

//清空cache
- (void)clearCaches;

@end
