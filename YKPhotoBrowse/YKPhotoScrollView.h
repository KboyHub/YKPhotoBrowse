//
//  YKPhotoScrollView.h
//  YKPhotoBrowse
//
//  Created by 闫康 on 16/7/8.
//  Copyright © 2016年 yankang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YKPhotoScrollVewDelegate <NSObject>

- (void)tapImageViewTappedWithObject:(id)sender;

@end

@interface YKPhotoScrollView : UIScrollView

@property (weak) id<YKPhotoScrollVewDelegate>p_delegate;

- (void) setContentWithFrame:(CGRect)rect;
- (void) setImage:(UIImage *)image;
- (void) setAnimationRect;
- (void) rechangeInitRect;


@end
