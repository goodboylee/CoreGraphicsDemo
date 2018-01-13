//
//  LayerView.m
//  CoreGraphicDemo
//
//  Created by lotus on 2018/1/5.
//  Copyright © 2018年 lotus. All rights reserved.
//

#import "LayerView.h"

@implementation LayerView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
//    [self drawFlag1WithRect:rect];
    [self drawFlag2WithRect:rect];
}


/**
 compute the CGLayer object's coordinate to draw layer object.
 */
- (void)drawFlag1WithRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //fill the background to white color
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    CGSize flagSize = CGSizeMake(160, 120);
    //create red stripe layer object
    CGFloat stripeSpace = (flagSize.height / 7);
    CGFloat stripeNum = 7;
    CGSize stripeSize = CGSizeMake(SCREEN_WIDTH, stripeSpace);
    CGLayerRef stripeLayer = CGLayerCreateWithContext(context, stripeSize, NULL);
    CGContextRef stripeLayerContext = CGLayerGetContext(stripeLayer);
    
    //draw content to the  stripe layer context
    CGContextSetFillColorWithColor(stripeLayerContext, [UIColor redColor].CGColor);
    CGContextFillRect(stripeLayerContext, CGRectMake(0, 0, SCREEN_WIDTH, stripeSpace));
    
    //draw the stripe layer
    CGFloat stripeX = 0, stripeY = 0;
    for (NSInteger i = 0; i < stripeNum; i++) {
        stripeY = i *(stripeSpace + stripeSpace);
        CGContextDrawLayerAtPoint(context, (CGPoint){stripeX, stripeY}, stripeLayer);
    }
    
    //draw the start background
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextFillRect(context, (CGRect){CGPointZero, flagSize});
    
    //create start layer object
    CGSize startSize = CGSizeMake(20, 20);
    CGFloat startSpace_H = (flagSize.width - 6 * startSize.height) / (6 + 1);
    CGFloat startSpace_V = (flagSize.height - 5 * startSize.width) / (5 + 1);
    CGLayerRef startLayer = CGLayerCreateWithContext(context, startSize, NULL);
    CGContextRef startContext = CGLayerGetContext(startLayer);
    
    //draw the start path to the start layer context
    const CGPoint startPoints[] = {{10 , 5}, {12.5 , 8},
        {15 , 8}, {12.5 , 11},
        {15 , 15}, {10 , 11},
        {5 , 15}, {7.5 , 11},
        {5 , 8}, {7.5 , 8},
    };
    CGContextSetFillColorWithColor(startContext, [UIColor whiteColor].CGColor);
    CGContextAddLines(startContext, startPoints, 10);
    CGContextFillPath(startContext);
    
    //draw 5 * 6 starts
    CGFloat startX, startY;
    for (NSInteger i = 0; i < 5; i++) {
        for (NSInteger j = 0; j < 6; j++) {
            startX = ceilf(startSpace_H + (startSize.width + startSpace_H) * j);
            startY = ceilf(startSpace_V + (startSize.height + startSpace_V) * i);
            CGContextDrawLayerAtPoint(context, (CGPoint){startX, startY}, startLayer);
        }
    }
    
    //draw 5 * 4 startsr
    for (NSInteger i = 0; i < 4; i++) {
        for (NSInteger j = 0; j < 5; j++) {
            startX = ceilf(startSpace_H + startSize.width / 2 + (startSize.width + startSpace_H) * j);
            startY = ceilf(startSpace_V + startSize.height / 2 + (startSize.height + startSpace_V) * i);
            
            CGContextDrawLayerAtPoint(context, (CGPoint){startX, startY}, startLayer);
        }
    }
    
    //release memory
    CGLayerRelease(stripeLayer);
    CGLayerRelease(startLayer);
    
}


/**
 translate the context to draw the CGLayer object.
 */
- (void)drawFlag2WithRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //fill the background to white color
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    CGSize flagSize = CGSizeMake(160, 120);
    //create red stripe layer object
    CGFloat stripeSpace = (flagSize.height / 7);
    CGFloat stripeNum = 7;
    CGSize stripeSize = CGSizeMake(SCREEN_WIDTH, stripeSpace);
    CGLayerRef stripeLayer = CGLayerCreateWithContext(context, stripeSize, NULL);
    CGContextRef stripeLayerContext = CGLayerGetContext(stripeLayer);
    
    //draw content to the  stripe layer context
    CGContextSetFillColorWithColor(stripeLayerContext, [UIColor redColor].CGColor);
    CGContextFillRect(stripeLayerContext, CGRectMake(0, 0, SCREEN_WIDTH, stripeSpace));
    
    //draw the stripe layer
    CGContextSaveGState(context);
    CGFloat stripeX = 0, stripeY = 0;
    for (NSInteger i = 0; i < stripeNum; i++) {
        stripeY = i *(stripeSpace + stripeSpace);
        CGContextDrawLayerAtPoint(context, CGPointZero, stripeLayer);
        CGContextTranslateCTM(context, stripeX, (stripeSpace + stripeSpace));
    }
    CGContextRestoreGState(context);
    
    //draw the start background
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextFillRect(context, (CGRect){CGPointZero, flagSize});
    
    //create start layer object
    CGSize startSize = CGSizeMake(20, 20);
    CGFloat startSpace_H = ceil((flagSize.width - 6 * startSize.height) / (6 + 1));
    CGFloat startSpace_V = ceil((flagSize.height - 5 * startSize.width) / (5 + 1));
    CGLayerRef startLayer = CGLayerCreateWithContext(context, startSize, NULL);
    CGContextRef startContext = CGLayerGetContext(startLayer);
    
    //draw the start path to the start layer context
    const CGPoint startPoints[] = {{10 , 5}, {12.5 , 8},
        {15 , 8}, {12.5 , 11},
        {15 , 15}, {10 , 11},
        {5 , 15}, {7.5 , 11},
        {5 , 8}, {7.5 , 8},
    };
    CGContextSetFillColorWithColor(startContext, [UIColor whiteColor].CGColor);
    CGContextAddLines(startContext, startPoints, 10);
    CGContextFillPath(startContext);
    
    //draw 5 * 6 starts
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, startSpace_H, startSpace_V);
    NSInteger i, j;
    for (i = 0; i < 5; i++) {
        for (j = 0; j < 6; j++) {
            CGContextDrawLayerAtPoint(context, CGPointZero, startLayer);
            CGContextTranslateCTM(context, ((startSize.width + startSpace_H)), 0);
        }
        CGContextTranslateCTM(context, -((startSize.width + startSpace_H) * j), (startSize.height + startSpace_V));
    }
    CGContextRestoreGState(context);
    
    //draw 5 * 4 startsr
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, startSpace_H + startSize.width / 2, startSpace_V + startSize.height / 2);
    for ( i = 0; i < 4; i++) {
        for ( j = 0; j < 5; j++) {
            CGContextDrawLayerAtPoint(context, CGPointZero, startLayer);
            CGContextTranslateCTM(context, startSize.width + startSpace_H, 0);
        }
        CGContextTranslateCTM(context, -((startSize.width + startSpace_H) * j), (startSize.height + startSpace_V));
    }
    CGContextRestoreGState(context);
    
    //release memory
    CGLayerRelease(stripeLayer);
    CGLayerRelease(startLayer);
}
@end









