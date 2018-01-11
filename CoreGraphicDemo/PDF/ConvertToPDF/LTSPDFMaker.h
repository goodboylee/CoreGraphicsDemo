//
//  PDFMaker.h
//  CoreGraphicDemo
//
//  Created by lotus on 2018/1/11.
//  Copyright © 2018年 lotus. All rights reserved.
//

/**
 convert image to PDF
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PDFMakerImageType){
    PDFMakerImageTypeJPG = 0,
    PDFMakerImageTypePNG
};

@interface LTSPDFMaker : NSObject


/**
 create pdf file from image

 @param imageData 图片数据
 @param fileName 最终保存的pdf文件名
 @param pdfsize pdf文件大小
 @param pwd pdf密码
 @param imageType 原始图片类型
 */
+ (void)createPDFWithImageData:(NSData *)imageData
                       pdfsize:(CGSize)pdfsize
                outputFileName:(NSString *)fileName
                      password:(NSString *)pwd
                     imageType:(PDFMakerImageType)imageType;


/**
 获取pdf文件路径

 @param fileName 文件名，该文件名应该和生成pdf时候使用的文件名一样
 @return pdf文件路径
 */
+ (NSString *)pdfPathWithFileName:(NSString *)fileName;
@end
