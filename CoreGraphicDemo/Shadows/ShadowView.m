//
//  ShadowView.m
//  CoreGraphicDemo
//
//  Created by lotus on 2017/12/14.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "ShadowView.h"

@implementation ShadowView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    CGSize offset = CGSizeMake(10, 10);
    CGContextSetShadow(context, offset, 8);
    CGContextSetFillColorWithColor(context, [UIColor cyanColor].CGColor);
    CGContextFillRect(context, CGRectMake(20, 100, 150, 100));
    
    //create color
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat component[] = {0.3,0.1,0.2,0.5};
    CGColorRef color = CGColorCreate(colorSpace, component);
    
//    CGContextSetShadowWithColor(context, offset, 5, [UIColor redColor].CGColor);
    CGContextSetShadowWithColor(context, offset, 6, color);
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextFillRect(context, CGRectMake(20, 250, 150, 100));
    
    CGColorSpaceRelease(colorSpace);
    CGColorRelease(color);
}



@end
