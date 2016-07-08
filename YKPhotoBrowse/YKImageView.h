//
//  YKImageView.h
//  YKPhotoBrowse
//
//  Created by 闫康 on 16/7/8.
//  Copyright © 2016年 yankang. All rights reserved.
//

#import <UIKit/UIKit.h>

//点击事件代理
@protocol YKImageViewDelegate <NSObject>

- (void)imageViewTapedWithObject:(id)sender;

@end

@interface YKImageView : UIImageView

@property (nonatomic, strong) id identifier;

@property (nonatomic,weak)id<YKImageViewDelegate>delegate;

@end
