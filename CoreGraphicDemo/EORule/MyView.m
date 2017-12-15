//
//  MyView.m
//  CoreGraphicDemo
//
//  Created by lotus on 2017/12/7.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "MyView.h"

@implementation MyView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [self drawImage:rect.size];
}

- (void)drawImage:(CGSize)size{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(context, 1, 0, 0, 1);
    CGContextSetRGBStrokeColor(context, 0, 1, 0, 1);
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, size.width, size.height));
    CGContextAddEllipseInRect(context, CGRectMake(50, 50, size.width - 50 * 2, size.height - 50 * 2));
    CGContextAddEllipseInRect(context, CGRectMake(60, 60, size.width - 60 * 2, size.height - 60 * 2));
    CGContextDrawPath(context, kCGPathEOFillStroke);
    
    
}





@end
