//
//  GradientView.m
//  CoreGraphicDemo
//
//  Created by lotus on 2017/12/14.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "GradientView.h"

@implementation GradientView
{
    GradientType _type;
}

- (instancetype)initWithFrame:(CGRect)frame type:(GradientType)type{
    self = [super initWithFrame:frame];
    if (self) {
        _type = type;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    if (_type == GradientTypeColorLinear) {
        [self drawColorLinearGradientWithRect:rect];
    }else if (_type == GradientTypeAlphaLinear){
        [self drawAlphaLinearGradientWithRect:rect];
    }else if (_type == GradientTypeColorRadial){
        [self drawColorRadialGradientWithRect:rect];
    }else if (_type == GradientTypeAlphaRadial){
        [self drawAlphaRadialGradientWithRect:rect];
    }
}

- (void)drawColorLinearGradientWithRect:(CGRect)rect{
    
    CGContextRef  context = UIGraphicsGetCurrentContext();
    
    //fill background
//    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
//    CGContextFillRect(context, rect);
    
    size_t num_locations = 2;
    CGPoint startPoint = CGPointMake(0, 30), endPoint = CGPointMake(0, rect.size.height - 30);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
    CGFloat components[] = {1,0,0,1,
                            0,1,0,1};
    CGFloat locations[] = {0.0, 1.0};
    CGGradientRef gradientObject = CGGradientCreateWithColorComponents(colorSpace, components, locations, num_locations);
    
    //切换最后一个参数可以查看相关效果
    CGContextDrawLinearGradient(context, gradientObject, startPoint, endPoint, 0);

    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradientObject);
    
}

- (void)drawAlphaLinearGradientWithRect:(CGRect)rect{
    CGContextRef  context = UIGraphicsGetCurrentContext();
    
    //fill background
//    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
//    CGContextFillRect(context, rect);
    
    size_t num_locations = 2;
    CGPoint startPoint = CGPointMake(0, 30), endPoint = CGPointMake(0, rect.size.height - 30);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
    CGFloat components[] = {1,0,0,1,
                            1,0,0,0};
    CGFloat locations[] = {0.0, 1.0};
    CGGradientRef gradientObject = CGGradientCreateWithColorComponents(colorSpace, components, locations, num_locations);
    
    //切换最后一个参数可以查看相关效果
    CGContextDrawLinearGradient(context, gradientObject, startPoint, endPoint, 0);
    
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradientObject);
}

- (void)drawColorRadialGradientWithRect:(CGRect)rect{
    CGContextRef  context = UIGraphicsGetCurrentContext();
    
    //fill background
    //    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    //    CGContextFillRect(context, rect);
    
    size_t num_locations = 2;
    CGPoint startCenter = CGPointMake(30, 30), endCenter = CGPointMake(rect.size.width - 50, rect.size.height - 50);
    CGFloat startRadius = 20, endRadius = 40;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
    CGFloat components[] = {1,0,0,1,
                            0,1,0,1};
    CGFloat locations[] = {0.0, 1.0};
    CGGradientRef gradientObject = CGGradientCreateWithColorComponents(colorSpace, components, locations, num_locations);
    
    //切换最后一个参数可以查看相关效果
    CGContextDrawRadialGradient(context, gradientObject, startCenter, startRadius, endCenter, endRadius, 0);
    
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradientObject);
}

- (void)drawAlphaRadialGradientWithRect:(CGRect)rect{
    CGContextRef  context = UIGraphicsGetCurrentContext();
    
    //fill background
    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextFillRect(context, rect);
    
    size_t num_locations = 2;
    CGPoint startCenter = CGPointMake(30, 30), endCenter = CGPointMake(rect.size.width - 50, rect.size.height - 50);
    CGFloat startRadius = 20, endRadius = 40;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
    CGFloat components[] = {1,0,0,1,
                            1,0,0,0};
    CGFloat locations[] = {0.0, 1.0};
    CGGradientRef gradientObject = CGGradientCreateWithColorComponents(colorSpace, components, locations, num_locations);
    
    //切换最后一个参数可以查看相关效果
    CGContextDrawRadialGradient(context, gradientObject, startCenter, startRadius, endCenter, endRadius, 0);
    
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradientObject);
}

@end













