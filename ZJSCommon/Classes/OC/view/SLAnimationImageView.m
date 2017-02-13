//
//  AnimationImageView.m
//  Snap
//
//  Created by ZhangJingshun on 14/12/18.
//  Copyright (c) 2014年 SengLed. All rights reserved.
//

#import "SLAnimationImageView.h"

@implementation SLAnimationImageView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doAnimation:) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;
}

//nib 文件加载调用此方法 解决前后台切换，图片动画停止的问题。 by zjs
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doAnimation:) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;
}

- (void)setImage:(UIImage *)image{
    [super setImage:image];
    self.bounds = CGRectMake(0, 0, image.size.width, image.size.height);

}

- (void)startAnimating{
    BOOL isAnimating = [self isAnimating];
    if (isAnimating) {
        return;
    }
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 0.5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 9999;
    
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    self.hidden = NO;
    [self.superview bringSubviewToFront:self];
}

- (BOOL)isAnimating{
    if ([self.layer animationKeys]) {
        return YES;
    }
    return NO;
}

- (void)stopAnimating{
    if ([self.layer animationKeys]) {
        [self.layer removeAllAnimations];
    }
    self.hidden = YES;
}

-(void)doAnimation:(NSNotification *)notify{
    BOOL isHidden = self.hidden;
    if (isHidden == NO) {
        [self stopAnimating];
        [self startAnimating];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
