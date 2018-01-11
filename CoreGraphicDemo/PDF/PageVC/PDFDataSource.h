//
//  PDFDataSource.h
//  CoreGraphicDemo
//
//  Created by lotus on 2018/1/9.
//  Copyright © 2018年 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PDFINSTANCE [PDFDataSource shareInstance]
@class LTSPDFView;
@interface PDFDataSource : NSObject

+ (instancetype)shareInstance;
- (LTSPDFView *)pdfViewForPage:(NSInteger)page;
- (NSInteger)totalPages;
@end
