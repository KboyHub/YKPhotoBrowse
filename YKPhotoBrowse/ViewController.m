//
//  ViewController.m
//  YKPhotoBrowse
//
//  Created by 闫康 on 16/7/8.
//  Copyright © 2016年 yankang. All rights reserved.
//

#import "ViewController.h"
#import "YKImageView.h"
#import "YKPhotoScrollView.h"

@interface ViewController ()<UIScrollViewDelegate,YKImageViewDelegate,YKPhotoScrollVewDelegate>
{
    UIScrollView *browseScrollView;//图片scrollView
    NSUInteger currentIndex;       //点击那张图
    UIView *markView;              //背景View
    UIView *browseView;            //browseView
    UIPageControl *pageControl;    //小圆点
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i = 0; i < 3; i ++)
    {
    YKImageView *tmpView = [[YKImageView alloc] initWithFrame:CGRectMake(5+105*i, 50, 100, 100)];
    tmpView.delegate = self;
    tmpView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i+1]];
    tmpView.tag = 10 + i;
    [self.view addSubview:tmpView];
    }
    
   
    browseView = [[UIView alloc] initWithFrame:self.view.bounds];
    browseView.backgroundColor = [UIColor clearColor];
    browseView.alpha = 0;
    [self.view addSubview:browseView];
    
    markView = [[UIView alloc] initWithFrame:browseView.bounds];
    markView.backgroundColor = [UIColor blackColor];
    markView.alpha = 0.0;
    [browseView addSubview:markView];
    browseScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [browseView addSubview:browseScrollView];
    browseScrollView.pagingEnabled = YES;
    browseScrollView.delegate = self;
    CGSize contentSize = browseScrollView.contentSize;
    contentSize.height = self.view.bounds.size.height;
    contentSize.width = self.view.bounds.size.width * 3;
    browseScrollView.contentSize = contentSize;
    
    pageControl = [[UIPageControl alloc] init];
    pageControl.userInteractionEnabled = NO;
    pageControl.numberOfPages = 3;
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.frame = CGRectMake(0, self.view.bounds.size.height-30, self.view.bounds.size.width, 20);
    pageControl.alpha = 0.0;
    [browseView addSubview:pageControl];
    
}

- (void)imageViewTapedWithObject:(id)sender{
    [self.view bringSubviewToFront:browseView];
    browseView.alpha = 1.0;
    
    YKImageView *imageView = sender;
    currentIndex = imageView.tag - 10;
    pageControl.currentPage = currentIndex;
    
    //转换后的rect
    CGRect convertRect = [[imageView superview] convertRect:imageView.frame toView:self.view];
    
    CGPoint contentOffset = browseScrollView.contentOffset;
    contentOffset.x = currentIndex*self.view.bounds.size.width;
    browseScrollView.contentOffset = contentOffset;
    
    //添加
    [self addSubImgView];
    
    YKPhotoScrollView *photoScrollView = [[YKPhotoScrollView alloc] initWithFrame:(CGRect){contentOffset,browseScrollView.bounds.size}];
    [photoScrollView setContentWithFrame:convertRect];
    [photoScrollView setImage:imageView.image];
    [browseScrollView addSubview:photoScrollView];
    photoScrollView.p_delegate = self;
    
    [self performSelector:@selector(setOriginFrame:) withObject:photoScrollView afterDelay:0.1];
    
}

- (void)addSubImgView{
    for (UIView *tmpView in browseScrollView.subviews)
    {
        [tmpView removeFromSuperview];
    }
    
    for (int i = 0; i < 3; i ++)
    {
        if (i == currentIndex)
        {
            continue;
        }
        YKImageView *tmpView = (YKImageView *)[self.view viewWithTag:10 + i];
        
        //转换后的rect
        CGRect convertRect = [[tmpView superview] convertRect:tmpView.frame toView:self.view];
        
        YKPhotoScrollView *tmpImgScrollView = [[YKPhotoScrollView alloc] initWithFrame:(CGRect){i*browseScrollView.bounds.size.width,0,browseScrollView.bounds.size}];
        [tmpImgScrollView setContentWithFrame:convertRect];
        [tmpImgScrollView setImage:tmpView.image];
        [browseScrollView addSubview:tmpImgScrollView];
        tmpImgScrollView.p_delegate = self;
        
        [tmpImgScrollView setAnimationRect];
    }
}

- (void)setOriginFrame:(YKPhotoScrollView *)sender{
    [UIView animateWithDuration:0.4 animations:^{
        [sender setAnimationRect];
        markView.alpha = 1.0;
        pageControl.alpha = 1.0;
    }];
}

- (void)tapImageViewTappedWithObject:(id)sender {
    YKPhotoScrollView *tmpImgView = sender;
    
    [UIView animateWithDuration:0.5 animations:^{
        markView.alpha = 0;
        pageControl.alpha = 0.0;
        [tmpImgView rechangeInitRect];
    } completion:^(BOOL finished) {
        browseView.alpha = 0;
    }];

}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    currentIndex = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = currentIndex;
}

@end
