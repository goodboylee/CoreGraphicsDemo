//
//  PDFViewController.h
//  CoreGraphicDemo
//
//  Created by lotus on 2018/1/9.
//  Copyright © 2018年 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFViewController : UIViewController

+ (PDFViewController *)pdfViewControllerForIndex:(NSInteger)index;
- (NSInteger)pageIndex;
@end
