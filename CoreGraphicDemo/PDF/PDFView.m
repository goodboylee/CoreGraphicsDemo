//
//  PDFView.m
//  CoreGraphicDemo
//
//  Created by lotus on 2018/1/5.
//  Copyright © 2018年 lotus. All rights reserved.
//

#import "PDFView.h"

@interface PDFView()
{
    CGPDFDocumentRef _docment;
    size_t _pageNumber;
}
@end;
@implementation PDFView

- (id)initWithFrame:(CGRect)frame pdfDocument:(CGPDFDocumentRef)pdfDocument pageNumber:(size_t)pageNumber{
    self = [super initWithFrame:frame];
    if (self) {
        _docment = pdfDocument;
        _pageNumber = pageNumber;
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    //get the page
    CGPDFPageRef page = CGPDFDocumentGetPage(_docment, _pageNumber);
    if (page == NULL) {
        NSLog(@"the page is not exist.");
        return;
    }
    
    //create the context use the rgba color space
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //fill the background color to yellowColor
    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextFillRect(context, rect);
    
    //transform the coordinate
    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1, -1);
    
    CGContextSaveGState(context);
    //creates an affine transform by mapping a box in a PDF page to a rectangle you specify
    CGAffineTransform transform = CGPDFPageGetDrawingTransform(page, kCGPDFMediaBox, self.bounds, 0, YES);
    CGContextConcatCTM(context, transform);
    CGContextClipToRect(context, CGPDFPageGetBoxRect(page, kCGPDFMediaBox));
    CGContextDrawPDFPage(context, page);
    CGContextRestoreGState(context);
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








