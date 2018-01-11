//
//  LTSPDFView.h
//  CoreGraphicDemo
//
//  Created by lotus on 2018/1/11.
//  Copyright © 2018年 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTSPDFView : UIView

/**
 绘制PDF
 
 @param frame pdf大小
 @param pdfDocument 包含pdf信息的CGPDFDocumentRef对象
 @param pageNumber 在CGPDFDocumentRef对象中对应的第几页pdf文件，从1开始
 @return pdfview
 */
- (id)initWithFrame:(CGRect)frame pdfDocument:(CGPDFDocumentRef)pdfDocument pageNumber:(size_t)pageNumber;
@end
