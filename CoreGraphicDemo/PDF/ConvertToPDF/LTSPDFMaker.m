//
//  PDFMaker.m
//  CoreGraphicDemo
//
//  Created by lotus on 2018/1/11.
//  Copyright © 2018年 lotus. All rights reserved.
//

#import "LTSPDFMaker.h"

void drawPDFContent(CGContextRef context, CGRect rect, CFDataRef imageData, PDFMakerImageType imageType){
    
    //get the CGImageRef
    CGImageRef imageRef = NULL;
    CGDataProviderRef provider = CGDataProviderCreateWithCFData(imageData);
    if (imageType == PDFMakerImageTypeJPG) {
        imageRef = CGImageCreateWithJPEGDataProvider(provider, NULL, NO, kCGRenderingIntentDefault);
    }else if (imageType == PDFMakerImageTypePNG){
        imageRef = CGImageCreateWithPNGDataProvider(provider, NULL, NO, kCGRenderingIntentDefault);
    }else{
        //TODO:
    }
    
    CGContextDrawImage(context, rect, imageRef);
    
    //release
    CGDataProviderRelease(provider);
    CGImageRelease(imageRef);
}

void createPDF(CFDataRef imageData, CGRect pdfRect, CFStringRef filePath, CFStringRef pdfPWD, PDFMakerImageType imageType){
    
    //使用NSURL构建的CFURLRef对象不可用
    //get the file url
    CFURLRef fileURL = CFURLCreateWithFileSystemPath(NULL, filePath, kCFURLPOSIXPathStyle, NO);
    
    //auxiliary info
    CFMutableDictionaryRef auxInfo = CFDictionaryCreateMutable(NULL, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    CFDictionarySetValue(auxInfo, kCGPDFContextTitle, CFSTR("Blocks 编程要点"));
    CFDictionarySetValue(auxInfo, kCGPDFContextAuthor, CFSTR("lotus lee"));
    CFDictionarySetValue(auxInfo, kCGPDFContextAllowsPrinting, kCFBooleanTrue);
    if (pdfPWD) {
        CFDictionarySetValue(auxInfo, kCGPDFContextUserPassword, pdfPWD);
        CFDictionarySetValue(auxInfo, kCGPDFContextOwnerPassword, pdfPWD);
    }
    
    //page description
    CFDataRef rectData = CFDataCreate(NULL, (const UInt8 *)&pdfRect, sizeof(pdfRect));
    CFMutableDictionaryRef pageInfo = CFDictionaryCreateMutable(NULL, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    CFDictionarySetValue(pageInfo, kCGPDFContextMediaBox, rectData);
    
    //create pdf context
    CGContextRef pdfContext = CGPDFContextCreateWithURL(fileURL, &pdfRect, auxInfo);
    if (pdfContext == NULL) {
        NSLog(@"create pdf context fail.");
        //release
        CFRelease(imageData);
        CFRelease(filePath);
        if (pdfPWD) {
            CFRelease(pdfPWD);
        }
        CFRelease(fileURL);
        CFRelease(auxInfo);
        CFRelease(rectData);
        CFRelease(pageInfo);
        CGContextRelease(pdfContext);
        return;
    }
    //begin to make pdf
    CGPDFContextBeginPage(pdfContext, pageInfo);
    
    drawPDFContent(pdfContext, pdfRect, imageData, imageType);
    
    CGPDFContextEndPage(pdfContext);
    
    
    //release
    CFRelease(imageData);
    CFRelease(filePath);
    if (pdfPWD) {
        CFRelease(pdfPWD);
    }
    CFRelease(fileURL);
    CFRelease(auxInfo);
    CFRelease(rectData);
    CFRelease(pageInfo);
    CGContextRelease(pdfContext);
}

NSString *pdfFilePath(NSString *fileName){
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingPathComponent:fileName];
    return path;
}

@implementation LTSPDFMaker

+ (void)createPDFWithImageData:(NSData *)imageData
                       pdfsize:(CGSize)pdfsize
                outputFileName:(NSString *)fileName
                      password:(NSString *)pwd
                     imageType:(PDFMakerImageType)imageType{
    
    CFDataRef imgData = (__bridge_retained CFDataRef)imageData;
    CFStringRef passWord = NULL;
    if (pwd.length) {
        passWord = (__bridge_retained CFStringRef)pwd;
    }
    
    
    //get the file path to save
    NSString *path = pdfFilePath(fileName);
    CFStringRef filePath = (__bridge_retained CFStringRef)path;
    
    //get the pdf size
    CGRect rect;
    if (CGSizeEqualToSize(pdfsize, CGSizeZero)) {
        UIImage *image = [UIImage imageWithData:imageData];
        rect = (CGRect){CGPointZero, image.size};
    }else{
        //pdf rect
        rect = (CGRect){CGPointZero, pdfsize};
    }
    
    
    createPDF(imgData, rect, filePath, passWord, imageType);
}

+ (NSString *)pdfPathWithFileName:(NSString *)fileName{
    NSParameterAssert(fileName.length);
    return pdfFilePath(fileName);
}

@end
