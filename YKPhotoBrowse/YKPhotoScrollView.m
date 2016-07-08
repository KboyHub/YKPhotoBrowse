//
//  YKPhotoScrollView.m
//  YKPhotoBrowse
//
//  Created by 闫康 on 16/7/8.
//  Copyright © 2016年 yankang. All rights reserved.
//

#import "YKPhotoScrollView.h"

@interface YKPhotoScrollView ()<UIScrollViewDelegate>
{
    
    UIImageView *imgView;
    
    CGRect scaleOriginRect;//记录位置
    
    CGSize imgSize;//图片大小
    
    CGRect initRect;//缩放前大小
    
}

@end

@implementation YKPhotoScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bouncesZoom = YES;
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.minimumZoomScale = 1.0;
        
        imgView = [[UIImageView alloc]init];
        imgView.clipsToBounds = YES;
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imgView];
    }
    return self;
}

-(void)setContentWithFrame:(CGRect)rect{
    imgView.frame = rect;
    initRect = rect;
}

- (void)setAnimationRect {
    imgView.frame = scaleOriginRect;
}

- (void)rechangeInitRect {
    self.zoomScale = 1.0;
    imgView.frame = initRect;
}


- (void)setImage:(UIImage *)image {
    if (image) {
        imgView.image = image;
        imgSize = image.size;
        
        //判断首先缩放值
        float scaleX = self.frame.size.width/imgSize.width;
        float scaleY = self.frame.size.height/imgSize.height;
        
        //小的先放
        if(scaleX >scaleY){
            //Y方向先到边
            float imgViewWidth = imgSize.width * scaleY;
            self.maximumZoomScale = self.frame.size.width/imgViewWidth;
            
            scaleOriginRect = (CGRect){self.frame.size.width/2-imgViewWidth/2,0,imgViewWidth,self.frame.size.height};
        }else{
            //X方向先到边
            float imgViewHeight = imgSize.height * scaleX;
            self.maximumZoomScale = self.frame.size.height/imgViewHeight;
            
            scaleOriginRect = (CGRect){0,self.frame.size.height/2-imgViewHeight/2,self.frame.size.width,imgViewHeight};
        }
    }
}

#pragma mark - UIScrollViewDelegate 
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {

    return imgView;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGSize boundsSize = scrollView.bounds.size;
    CGRect imgFrame = imgView.frame;
    CGSize contentSize = scrollView.contentSize;
    CGPoint centerPoint = CGPointMake(contentSize.width/2, contentSize.height/2);
    
    if (imgFrame.size.width <= boundsSize.width) {
        centerPoint.x = boundsSize.width/2;
    }
    
    if (imgFrame.size.height <= boundsSize.height) {
        centerPoint.y = boundsSize.height/2;
    }
    imgView.center = centerPoint;
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if ([self.p_delegate respondsToSelector:@selector(tapImageViewTappedWithObject:)]){
        [self.p_delegate tapImageViewTappedWithObject:self];
    }
    
}




@end
