//
//  ViewController.m
//  CoreGraphicDemo
//
//  Created by lotus on 2017/12/7.
//  Copyright © 2017年 lotus. All rights reserved.
//

//VC
#import "ViewController.h"

//views
#import "MyView.h"
#import "ClipVIew.h"
#import "PatternView.h"
#import "ShadowView.h"
#import "TransparentView.h"
#import "SubImageView.h"
#import "LayerView.h"
#import "LTSPDFView.h"

//data
#import "LTSPDFMaker.h"


static NSString *const pdfName = @"rooster.pdf";
static NSString *const pdfPWD = @"123456";

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
{
    CGPDFDocumentRef _pdfDoc;
}
@property (weak, nonatomic) IBOutlet UIButton *pdfBtn;
@property (nonatomic, strong) LTSPDFView *pdfView;
@end




@implementation ViewController
- (void)dealloc{
    CGPDFDocumentRelease(_pdfDoc);
}
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

- (IBAction)makePDFFile:(id)sender {
    
    //make pdf
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"rooster" ofType:@"jpg"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];

    if (imageData == nil) {
        NSLog(@"making pdf, image isn't exist.");
        return;
    }
    [LTSPDFMaker createPDFWithImageData:imageData pdfsize:CGSizeMake(SCREEN_WIDTH, 300) outputFileName:pdfName password:pdfPWD imageType:PDFMakerImageTypeJPG];
    [self addPDFView];
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
    }else if (_type == UsageTypeCGLayer){
        [self addLayerView];
    }else if (_type == UsageTypeConvertImageToPDF){
        _pdfBtn.hidden = NO;
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
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGRect rect = CGRectMake(0, 100, size.width, size.height - 100);
    SubImageView *view = [[SubImageView alloc] initWithFrame:rect];
    [self.view addSubview:view];
}

- (void)addLayerView{
    LayerView *view = [[LayerView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT - 100)];
    [self.view addSubview:view];
}
- (void)addPDFView{
    
    NSString *pdfPath = [LTSPDFMaker pdfPathWithFileName:pdfName];
    
    CFURLRef pdfURL = CFURLCreateWithFileSystemPath(NULL, (__bridge CFStringRef)pdfPath, kCFURLPOSIXPathStyle, NO);
    CGPDFDocumentRef pdfDoc = CGPDFDocumentCreateWithURL(pdfURL);
    _pdfDoc = pdfDoc;
    if (pdfDoc == NULL) {
        NSLog(@"can't open the pdf document");
        CFRelease(pdfURL);
        return;
    }
    
    //check the document whether is encrypted or not.
    if (CGPDFDocumentIsEncrypted(pdfDoc)) {
        if (!CGPDFDocumentUnlockWithPassword(pdfDoc, [pdfPWD UTF8String])) {
            NSLog(@"can't unlock the pdf document.");
            CFRelease(pdfURL);
            CGPDFDocumentRelease(pdfDoc);
            return;
        }
    }
    
    if (_pdfView) {
        [_pdfView removeFromSuperview];
        _pdfView = nil;
    }
    LTSPDFView *view = [[LTSPDFView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 300) pdfDocument:pdfDoc pageNumber:1];
    _pdfView = view;
    if (view) {
        [self.view addSubview:view];
    }
    
    //release
    CFRelease(pdfURL);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
