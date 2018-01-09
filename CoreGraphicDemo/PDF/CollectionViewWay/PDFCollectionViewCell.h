//
//  PDFCollectionViewCell.h
//  CoreGraphicDemo
//
//  Created by lotus on 2018/1/6.
//  Copyright © 2018年 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>


@class PDFView;
@interface PDFCollectionViewCell : UICollectionViewCell

- (void)configureWithView:(PDFView *)view;
@end
