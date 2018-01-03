//
//  SubImageView.m
//  CoreGraphicDemo
//
//  Created by lotus on 2018/1/3.
//  Copyright © 2018年 lotus. All rights reserved.
//

#import "SubImageView.h"

@implementation SubImageView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGImageRef cgImage = [self CGImageWithName:@"rooster.jpg"];
    CGImageRef clipImage = CGImageCreateWithImageInRect(cgImage, CGRectMake(100, 100, 100, 100));
//    CGContextDrawImage(context, CGRectMake(100, 100, 80, 80), clipImage);
    [[UIImage imageWithCGImage:clipImage] drawInRect:CGRectMake(100, 100, 80, 80)];
    
    CGImageRelease(cgImage);
    CGImageRelease(clipImage);
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
