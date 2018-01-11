//
//  PDFCollectionViewCell.m
//  CoreGraphicDemo
//
//  Created by lotus on 2018/1/6.
//  Copyright © 2018年 lotus. All rights reserved.
//

#import "PDFCollectionViewCell.h"
#import "LTSPDFView.h"

@interface PDFCollectionViewCell()<UIScrollViewDelegate>


/**
 used to zoom the pdf view
 */
@property (nonatomic, strong) UIScrollView *zoomSclView;


/**
 used to show the pdf content
 */
@property (nonatomic, strong) PDFView *pdfContentView;
@end

@implementation PDFCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureSubviews];
    }
    
    return self;
}

- (void)configureSubviews{
    UIScrollView *tempSclView = [[UIScrollView alloc] initWithFrame:self.contentView.bounds];
    tempSclView.showsVerticalScrollIndicator = NO;
    tempSclView.showsHorizontalScrollIndicator = NO;
    tempSclView.maximumZoomScale = 2;
    tempSclView.delegate = self;
    _zoomSclView = tempSclView;
    [self.contentView addSubview:tempSclView];
}

- (void)configureWithView:(PDFView *)view{
//    [_zoomSclView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([obj isKindOfClass:[PDFView class]]) {
//            [obj removeFromSuperview];
//        }
//    }];
    
    [_zoomSclView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _pdfContentView = view;
    [_zoomSclView addSubview:view];
}

#pragma mark - scroll view delegate
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _pdfContentView;
}
@end








