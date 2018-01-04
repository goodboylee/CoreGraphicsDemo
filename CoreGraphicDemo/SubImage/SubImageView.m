//
//  SubImageView.m
//  CoreGraphicDemo
//
//  Created by lotus on 2018/1/3.
//  Copyright © 2018年 lotus. All rights reserved.
//

#import "SubImageView.h"

@implementation SubImageView

void myDrawFlag (CGContextRef context, CGRect* contextRect)
{
    int          i, j,
    num_six_star_rows = 5,
    num_five_star_rows = 4;
    CGFloat      start_x = 5.0,// 1
    start_y = 108.0,// 2
    red_stripe_spacing = 34.0,// 3
    h_spacing = 26.0,// 4
    v_spacing = 22.0;// 5
    CGContextRef myLayerContext1,
    myLayerContext2;
    CGLayerRef   stripeLayer,
    starLayer;
    CGRect       myBoundingBox,// 6
    stripeRect,
    starField;
    // ***** Setting up the primitives *****
    const CGPoint myStarPoints[] = {{ 5, 5},   {10, 15},// 7
        {10, 15},  {15, 5},
        {15, 5},   {2.5, 11},
        {2.5, 11}, {16.5, 11},
        {16.5, 11},{5, 5}};
    
    stripeRect  = CGRectMake (0, 0, 400, 17); // stripe// 8
    starField  =  CGRectMake (0, 102, 160, 119); // star field// 9
    
    myBoundingBox = CGRectMake (0, 0, contextRect->size.width, // 10
                                contextRect->size.height);
    
    // ***** Creating layers and drawing to them *****
    stripeLayer = CGLayerCreateWithContext (context, // 11
                                            stripeRect.size, NULL);
    myLayerContext1 = CGLayerGetContext (stripeLayer);// 12
    
    CGContextSetRGBFillColor (myLayerContext1, 1, 0 , 0, 1);// 13
    CGContextFillRect (myLayerContext1, stripeRect);// 14
    
    starLayer = CGLayerCreateWithContext (context,
                                          starField.size, NULL);// 15
    myLayerContext2 = CGLayerGetContext (starLayer);// 16
    CGContextSetRGBFillColor (myLayerContext2, 1.0, 1.0, 1.0, 1);// 17
    CGContextAddLines (myLayerContext2, myStarPoints, 10);// 18
    CGContextFillPath (myLayerContext2);    // 19
    
    // ***** Drawing to the window graphics context *****
    CGContextSaveGState(context);    // 20
    for (i=0; i< 7;  i++)   // 21
    {
        CGContextDrawLayerAtPoint (context, CGPointZero, stripeLayer);// 22
        CGContextTranslateCTM (context, 0.0, red_stripe_spacing);// 23
    }
    CGContextRestoreGState(context);// 24
    
    CGContextSetRGBFillColor (context, 0, 0, 0.329, 1.0);// 25
    CGContextFillRect (context, starField);// 26
    
    CGContextSaveGState (context);              // 27
    CGContextTranslateCTM (context, start_x, start_y);      // 28
    for (j=0; j< num_six_star_rows;  j++)   // 29
    {
        for (i=0; i< 6;  i++)
        {
            CGContextDrawLayerAtPoint (context,CGPointZero,
                                       starLayer);// 30
            CGContextTranslateCTM (context, h_spacing, 0);// 31
        }
        CGContextTranslateCTM (context, (-i*h_spacing), v_spacing); // 32
    }
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextTranslateCTM (context, start_x + h_spacing/2, // 33
                           start_y + v_spacing/2);
    for (j=0; j< num_five_star_rows;  j++)  // 34
    {
        for (i=0; i< 5;  i++)
        {
            CGContextDrawLayerAtPoint (context, CGPointZero,
                                       starLayer);// 35
            CGContextTranslateCTM (context, h_spacing, 0);// 36
        }
        CGContextTranslateCTM (context, (-i*h_spacing), v_spacing);// 37
    }
    CGContextRestoreGState(context);
    
    CGLayerRelease(stripeLayer);// 38
    CGLayerRelease(starLayer);        // 39
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
//
//    CGImageRef cgImage = [self CGImageWithName:@"rooster.jpg"];
//    CGImageRef clipImage = CGImageCreateWithImageInRect(cgImage, CGRectMake(100, 100, 100, 100));
//    //CGContextDrawImage(context, CGRectMake(100, 100, 80, 80), clipImage);
//    [[UIImage imageWithCGImage:clipImage] drawInRect:CGRectMake(100, 100, 80, 80)];
//    
//    
//    
//    CGImageRelease(cgImage);
//    CGImageRelease(clipImage);
    
//    myDrawFlag(context, &rect);
    
    
    CGPoint points[] = {{10, 10}, {100, 10}, {10, 100}};
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextSetLineWidth(context, 5);
    CGContextSetLineJoin(context, kCGLineJoinMiter);
    
    CGContextAddLines(context, points, 3);
//    CGContextClosePath(context);
//    CGContextStrokePath(context);
    CGContextFillPath(context);
    
}


- (CGImageRef)CGImageWithName:(NSString *)imageName{
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:imageName withExtension:nil];
    CFURLRef cfImageURL = (__bridge_retained CFURLRef)url;
    CGImageSourceRef imageSource = CGImageSourceCreateWithURL(cfImageURL, NULL);
    CGImageRef cgimge = CGImageSourceCreateImageAtIndex(imageSource, 0, NULL);
    CFRelease(cfImageURL);
    CFRelease(imageSource);
    return cgimge;
}
@end
