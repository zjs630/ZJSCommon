//
//  SLLoadingView.m
//  snap
//
//  Created by ZhangJingshun on 15/8/29.
//  Copyright (c) 2015年 sengled. All rights reserved.
//

#import "SLLoadingView.h"
#import "SLAnimationImageView.h"

@interface SLLoadingView()
@property (strong,nonatomic) SLAnimationImageView *imgView;

@end

@implementation SLLoadingView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置圆角和边框
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 4.0;
//        self.layer.borderWidth = 1.0;
//        self.layer.borderColor = [UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1.0].CGColor;
        self.backgroundColor = [UIColor whiteColor];
        
        [self addAnimationView];

    }
    return self;

}

- (void)addAnimationView{
    _imgView = [[SLAnimationImageView alloc] init];
    _imgView.image = [UIImage imageNamed:@"icon_loading"];
    [self addSubview:_imgView];
    [_imgView startAnimating];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.center = self.superview.center;
    self.bounds = CGRectMake(0, 0, 100, 80);
    
    CGFloat imgW = self.imgView.image.size.width;
    CGFloat imgH = self.imgView.image.size.height;
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    _imgView.frame = CGRectMake((w - imgW)/2, (h-imgH)/2, imgW, imgH);
    
}


@end
