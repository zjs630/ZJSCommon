//
//  UIImageView+SL.h
//  WifiLedController
//
//  Created by ZhangJingshun on 14/12/3.
//  Copyright (c) 2014年 SengLed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SL)

/** 设置图片，并根据第二个参数来决定是否对view大小设置为图片大小*/
- (void)imageWithName:(NSString *)imageName asBounds:(BOOL)asBounds;

@end
