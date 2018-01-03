//
//  ViewController.m
//  CoreGraphicDemo
//
//  Created by lotus on 2017/12/7.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "ViewController.h"
#import "MyView.h"
#import "ClipVIew.h"
#import "PatternView.h"
#import "ShadowView.h"
#import "TransparentView.h"
#import "SubImageView.h"


CGContextRef myConctext(size_t width, size_t height){

    size_t bitsPerComponent = 8;
    size_t bytesPerRow = width * 4;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
    CGContextRef context = CGBitmapContextCreate(NULL, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colorSpace);
    return context;
}

UIImage *customImage(void){
    CGContextRef context = myConctext(200, 200);
    CGContextTranslateCTM(context, 0, 200);
    CGContextScaleCTM(context, 1, -1);

//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 200), YES, [UIScreen mainScreen].scale);
//    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetRGBFillColor(context, 0, 0, 1, 1);
    CGContextFillRect(context, CGRectMake(0, 0, 200, 200));
    CGContextSetRGBFillColor(context, 1, 0, 0, 1);
    CGContextFillRect(context, CGRectMake(0, 0, 30, 30));
    CGContextSetRGBFillColor(context, 0, 1, 0, 1);
    CGContextFillRect(context, CGRectMake(0, 100, 200, 100));

    CGImageRef image = CGBitmapContextCreateImage(context);
    UIImage *img = [UIImage imageWithCGImage:image];

//    UIGraphicsEndImageContext();
    CGContextRelease(context);
    CGImageRelease(image);
    return img;
}

@interface ViewController ()

@end




@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
//    imgview.image = customImage();
//    [self.view addSubview:imgview];
    
    [self configureView];
    
    //about affine transform
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100, 100), YES, [UIScreen mainScreen].scale);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextTranslateCTM(context, 0, 100);
//    CGContextScaleCTM(context, 1, -1);
//
//    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
//    CGContextFillRect(context, CGRectMake(0, 0, 100, 100));
////    CGContextRotateCTM(context, -(300 * M_PI / 180));
////    CGContextScaleCTM(context, 0.5, 0.5);
//    CGContextDrawImage(context, CGRectMake(0, 0, 100, 100), [UIImage imageNamed:@"rooster.jpg"].CGImage);
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
//    imgView.backgroundColor = [UIColor yellowColor];
//    imgView.frame = CGRectMake(50, 100, 100, 100);
//    [self.view addSubview:imgView];
    
}


- (void)configureView{
    if (_type == UsageTypeEORule) {
        [self addEORuleView];
    }else if (_type == UsageTypeClip){
        [self addClipView];
    }else if (_type == UsageTypePatterns){
        [self addPatternView];
    }else if (_type == UsageTypeShadows){
        [self addShadowView];
    }else if (_type == UsageTypeTransparentLayer){
        [self addTransparentLayerView];
    }else if (_type == UsageTypeSubImage){
        [self addSubimageView];
    }
}

- (void)addEORuleView{
    MyView *view = [[MyView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];
}

- (void)addClipView{
    ClipVIew *view = [[ClipVIew alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];
}
- (void)addPatternView{
    PatternView *view = [[PatternView alloc] initWithFrame:CGRectMake(10, 150, 300, 200)];
    [self.view addSubview:view];
}
- (void)addShadowView{
    ShadowView *view = [[ShadowView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
}
- (void)addTransparentLayerView{
    TransparentView *view = [[TransparentView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
}
-(void)addSubimageView{
    SubImageView *view = [[SubImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
