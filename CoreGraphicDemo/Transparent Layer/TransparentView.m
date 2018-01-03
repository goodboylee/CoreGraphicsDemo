//
//  TransparentView.m
//  CoreGraphicDemo
//
//  Created by lotus on 2018/1/3.
//  Copyright © 2018年 lotus. All rights reserved.
//

#import "TransparentView.h"

@implementation TransparentView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //fill the background
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    //试下注释阴影，打开设置透明度的代码
    CGContextSetShadow(context, CGSizeMake(10, 20), 8);
//    CGContextSetAlpha(context, 0.5);
    CGContextBeginTransparencyLayer(context, NULL);
    
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(50, 100, 100, 100));
    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(120, 120, 100, 100));
    CGContextSetFillColorWithColor(context, [UIColor purpleColor].CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(80, 150, 100, 100));
    
    CGContextEndTransparencyLayer(context);
    
    CGContextSetFillColorWithColor(context, [UIColor cyanColor].CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(50, 300, 100, 100));

    
}


@end
