//
//  AnimationImageView.h
//  Snap
//
//  Created by ZhangJingshun on 14/12/18.
//  Copyright (c) 2014年 SengLed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLAnimationImageView : UIImageView
@property (nonatomic,assign) BOOL isAnimating;

/**
 开始动画
 */
- (void)startAnimating;

/**
 暂停动画
 */
- (void)stopAnimating;

@end
