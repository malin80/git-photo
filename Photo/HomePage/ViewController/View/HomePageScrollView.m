//
//  HomePageScrollView.m
//  Photo
//
//  Created by malin  on 2017/7/25.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "HomePageScrollView.h"


#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

@interface HomePageScrollView()
{
    NSArray *_dataSource;
}

@end

@implementation HomePageScrollView

-(id)initWithFrame:(CGRect)frame withDataSource:(NSArray *)dataSource {
    self = [super initWithFrame:frame];
    if (self) {
        _dataSource = dataSource;
        [self createScrollView];
    }
    return self;
}

- (void)createScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 250);
    scrollView.backgroundColor = [UIColor grayColor];
    scrollView.contentSize = CGSizeMake(_dataSource.count*SCREEN_WIDTH, 250);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.backgroundColor = [UIColor redColor];
    [self addSubview:scrollView];
}

@end
