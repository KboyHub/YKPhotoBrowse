//
//  YKImageView.m
//  YKPhotoBrowse
//
//  Created by 闫康 on 16/7/8.
//  Copyright © 2016年 yankang. All rights reserved.
//

#import "YKImageView.h"

@implementation YKImageView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapedImageView:)];
        [self addGestureRecognizer:tap];
        self.clipsToBounds = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)tapedImageView:(UIGestureRecognizer *)gesture {
    if ([self.delegate respondsToSelector:@selector(imageViewTapedWithObject:)]) {
        [self.delegate imageViewTapedWithObject:self];
    }
}

@end
