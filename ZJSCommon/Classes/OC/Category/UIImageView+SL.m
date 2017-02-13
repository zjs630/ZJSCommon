//
//  UIImageView+SL.m
//  WifiLedController
//
//  Created by ZhangJingshun on 14/12/3.
//  Copyright (c) 2014年 SengLed. All rights reserved.
//

#import "UIImageView+SL.h"
//#import "UIImage+SL.h"

@implementation UIImageView (SL)

- (void)imageWithName:(NSString *)imageName asBounds:(BOOL)asBounds {
    UIImage *image = [UIImage imageNamed:imageName];
    if (asBounds) {
        self.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    }
    [self setImage:image];
}

@end
