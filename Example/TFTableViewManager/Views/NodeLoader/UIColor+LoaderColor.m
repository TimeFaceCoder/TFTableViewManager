//
//  UIColor+LoaderColor.m
//  TFTableViewManager
//
//  Created by Melvin on 2018/8/20.
//  Copyright © 2018 TFAppleWork-Summer. All rights reserved.
//

#import "UIColor+LoaderColor.h"

@implementation UIColor (LoaderColor)


+ (UIColor *)backgroundFadedGrey {
    return [self colorWithRed:246.0/255.0 green:247.0/255.0 blue:248.0/255.0 alpha:1];
}
+ (UIColor *)gradientFirstStop {
    return [self colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
}
+ (UIColor *)gradientSecondStop {
    return [self colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1];
}


@end
