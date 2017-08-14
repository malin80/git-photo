//
//  HomePageScrollView.m
//  Photo
//
//  Created by malin  on 2017/7/25.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "HomePageScrollView.h"
#import "HomePagePesRequest.h"
#import "HomePageManager.h"
#import "ImageInfo.h"
#import "SDWebImageCache.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

@interface HomePageScrollView() <UIScrollViewDelegate>
{
    NSMutableArray *_dataSource;
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    NSTimer *_timer;
    NSInteger _currentPage;
}

@end

@implementation HomePageScrollView

-(id)initWithFrame:(CGRect)frame withIsHomePage:(BOOL)isHomePage {
    self = [super initWithFrame:frame];
    if (self) {
        [self addNotification];
        if (isHomePage) {
            [GET_SINGLETON_FOR_CLASS(HomePageManager) loadScrollViewImages];
        } else {
            [self loadScrollViewImagesSuccess];
        }
    }
    return self;
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadScrollViewImagesSuccess) name:@"loadScrollViewImagesSuccess" object:nil];
}

- (void)loadScrollViewImagesSuccess {
    _dataSource = GET_SINGLETON_FOR_CLASS(HomePageManager).scrollViewImages;
    [self createScrollView];
}

- (void)createScrollView
{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 250);
    _scrollView.backgroundColor = [UIColor grayColor];
    _scrollView.contentSize = CGSizeMake(_dataSource.count*SCREEN_WIDTH, 250);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor redColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    [self createImageView];
    [self createPageView];
}

- (void)createImageView {
    [self stopTimer];
    ImageInfo *info = [[ImageInfo alloc] init];
    for (int i = 0; i < _dataSource.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*ScreenWidth, 0, ScreenWidth, 250)];
        info = _dataSource[i];
        [SDWebImageCache getImageFromSDWebImageWithUrlString:[NSString stringWithFormat:@"%@%@",baseUrl,info.imageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            imageView.image = image;
        }];
        [_scrollView addSubview:imageView];
    }
    _currentPage = 0;
    [self startTimer];
}

- (void)createPageView {
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 220, ScreenWidth, 20)];
    _pageControl.backgroundColor = [UIColor clearColor];
    [_pageControl setCurrentPageIndicatorTintColor:[UIColor blackColor]];
    [_pageControl setPageIndicatorTintColor:[UIColor grayColor]];
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = _dataSource.count;
    [self addSubview:_pageControl];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = CGRectGetWidth(_scrollView.frame);
    NSUInteger page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _pageControl.currentPage = page;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _pageControl.currentPage = _currentPage;
}

#pragma mark --- NSTimer ---
- (void)startTimer {
       _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
      [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)changeImage {
    _currentPage++;
    [_scrollView setContentOffset:(CGPoint){_currentPage*ScreenWidth,0} animated:YES];
    if (_currentPage >= _dataSource.count-1) {
        [self stopTimer];
    }
}

@end
