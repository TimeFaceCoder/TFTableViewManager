//
//  CutoutView.m
//  TFTableViewManager
//
//  Created by Melvin on 2018/8/20.
//  Copyright © 2018 TFAppleWork-Summer. All rights reserved.
//

#import "CutoutView.h"
#import "UIColor+LoaderColor.h"

@implementation CutoutView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context,self.bounds);
    
    for (UIView *view in self.superview.subviews) {
        if (view != self) {
            CGContextSetBlendMode(context, kCGBlendModeClear);
            CGRect rect = self.frame;
            CGPathRef clipPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:view.layer.cornerRadius].CGPath;
            CGContextAddPath(context, clipPath);
            CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
            CGContextClosePath(context);
            CGContextFillPath(context);
        }
    }
}

- (void)layoutSubviews {
    [self setNeedsLayout];
}


@end
