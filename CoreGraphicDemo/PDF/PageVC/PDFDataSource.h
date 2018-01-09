//
//  PDFDataSource.h
//  CoreGraphicDemo
//
//  Created by lotus on 2018/1/9.
//  Copyright © 2018年 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PDFINSTANCE [PDFDataSource shareInstance]
@class PDFView;
@interface PDFDataSource : NSObject

+ (instancetype)shareInstance;
- (PDFView *)pdfViewForPage:(NSInteger)page;
- (NSInteger)totalPages;
@end
