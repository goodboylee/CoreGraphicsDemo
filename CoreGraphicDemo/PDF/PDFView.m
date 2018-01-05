//
//  PDFView.m
//  CoreGraphicDemo
//
//  Created by lotus on 2018/1/5.
//  Copyright © 2018年 lotus. All rights reserved.
//

#import "PDFView.h"

@implementation PDFView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    //create the context use the rgba color space
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context == NULL) {
        return;
    }
    
    //fill the background color to yellowColor
    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextFillRect(context, rect);
    
    //transform the coordinate
    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1, -1);
    
    //create pdf document
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Blocks 编程要点.pdf" withExtension:nil];
    if (url == nil) {
        NSLog(@"the url is not exist.");
        return;
    }
    CFURLRef pdfURL = (__bridge_retained CFURLRef)url;
    CGPDFDocumentRef pdfDocument = CGPDFDocumentCreateWithURL(pdfURL);
    
    size_t pdfNums = CGPDFDocumentGetNumberOfPages(pdfDocument);
    NSLog(@"total pdf numbers is %d", (int)pdfNums);
    
    //get the page
    CGPDFPageRef page = CGPDFDocumentGetPage(pdfDocument, 3);
    
    CGContextSaveGState(context);
    CGAffineTransform transform = CGPDFPageGetDrawingTransform(page, kCGPDFMediaBox, self.bounds, 0, YES);
    CGContextConcatCTM(context, transform);
    CGContextClipToRect(context, CGPDFPageGetBoxRect(page, kCGPDFMediaBox));
    CGContextDrawPDFPage(context, page);
    CGContextRestoreGState(context);
    
    //release memory
    CGPDFDocumentRelease(pdfDocument);
    CFRelease(pdfURL);
    
}

- (CGContextRef)createContextWithRect:(CGRect)rect{
    
    size_t bitsPerComponent = 8;
    size_t bytesPerRow = rect.size.width * 4;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
    CGContextRef context = CGBitmapContextCreate(NULL, rect.size.width, rect.size.height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colorSpace);
    if (context == NULL) {
        NSLog(@"create context fail.");
        return NULL;
    }
    return context;
}

@end








