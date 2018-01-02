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
    }else if (_type == GradientTypeShapeAxial){
        [self drawShapeAxialWithRect:rect];
    }else if (_type == GradientTypeShapeRadial){
        [self drawShapeRadialWithRect:rect];
    }
}

#pragma mark - gradient using CGGradientRef
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


#pragma mark - gradient using CGShadingRef

- (void)drawShapeAxialWithRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
    
    //create CGFunctionRef
    CGFunctionRef functionObject = myFuction(colorSpace);
    
    //create CGShadingRef object
    CGShadingRef shadingObject = CGShadingCreateAxial(colorSpace, CGPointMake(0, 0), CGPointMake(rect.size.width, 0), functionObject, false, false);
    
    CGContextDrawShading(context, shadingObject);
    
    //release
    CGColorSpaceRelease(colorSpace);
    CGFunctionRelease(functionObject);
    CGShadingRelease(shadingObject);
}

- (void)drawShapeRadialWithRect:(CGRect)rect{
    
}
static int count = 0;
static void myEvaluateCallback(void * __nullable info, const CGFloat *  in, CGFloat *  out){
    CGFloat v;
    size_t k, components;
    static const CGFloat c[] = {1, 0, .5, 0 };
    
    components = (size_t)info;
    count++;
    NSLog(@"count = %d", count);
    v = *in;
    for (k = 0; k < components -1; k++)
        *out++ = c[k] * v;
    *out++ = 1;
}

static CGFunctionRef myFuction(CGColorSpaceRef colorSpace){
    size_t numComponents;
    static const CGFloat input_value_range [2] = { 0, 0.5 };
    static const CGFloat output_value_ranges [8] = { 0, 1, 0, 1, 0, 1, 0, 1 };
    
    //用于生成颜色信息，包括r,g,b,alpha
    static const CGFunctionCallbacks callbacks = { 0,// 2
        &myEvaluateCallback,
        NULL };
    
    numComponents = 1 + CGColorSpaceGetNumberOfComponents (colorSpace);// 3
    
    return CGFunctionCreate ((void *) numComponents, // 4
                             1, // 5
                             input_value_range, // 6
                             numComponents, // 7
                             output_value_ranges, // 8
                             &callbacks);
}
@end













