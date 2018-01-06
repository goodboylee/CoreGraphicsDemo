//
//  PDFView.h
//  CoreGraphicDemo
//
//  Created by lotus on 2018/1/5.
//  Copyright © 2018年 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFView : UIView

- (id)initWithFrame:(CGRect)frame pdfDocument:(CGPDFDocumentRef)pdfDocument pageNumber:(size_t)pageNumber;
@end
