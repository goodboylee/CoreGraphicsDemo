//
//  ShapeGradientView.m
//  CoreGraphicDemo
//
//  Created by lotus on 2017/12/14.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "ShapeGradientView.h"

@implementation ShapeGradientView

static void myEvaluateCallback(void * __nullable info, const CGFloat *  in, CGFloat *  out){
    CGFloat v;
    size_t k, components;
    static const CGFloat c[] = {1, 0, .5, 0 };
    
    components = (size_t)info;
    
    v = *in;
    for (k = 0; k < components -1; k++)
        *out++ = c[k] * v;
    *out++ = 1;
}

static CGFunctionRef myFuction(CGColorSpaceRef colorSpace){
    size_t numComponents;
    static const CGFloat input_value_range [2] = { 0, 1 };
    static const CGFloat output_value_ranges [8] = { 0, 1, 0, 1, 0, 1, 0, 1 };
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

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
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


@end
