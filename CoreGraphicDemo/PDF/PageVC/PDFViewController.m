//
//  PDFViewController.m
//  CoreGraphicDemo
//
//  Created by lotus on 2018/1/9.
//  Copyright © 2018年 lotus. All rights reserved.
//

#import "PDFViewController.h"
#import "PDFDataSource.h"
#import "PDFView.h"

#define NAVBAR_HEIGHT       self.navigationController.navigationBar.frame.size.height
#define STATUSBAR_HEIGHT    [UIApplication sharedApplication].statusBarFrame.size.height
#define ITEM_SIZE           CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - STATUSBAR_HEIGHT - NAVBAR_HEIGHT)

@interface PDFViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_sclView;
    NSInteger _index;
    PDFView *_pdfView;
}
@end

@implementation PDFViewController

- (id)initWithIndex:(NSInteger)index{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _index = index;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"viewDidLayoutSubviews frame h:%f, bar H: %f", STATUSBAR_HEIGHT, NAVBAR_HEIGHT);
    NSLog(@"self view frame : %@", NSStringFromCGRect(self.view.frame));
    _sclView.frame = (CGRect){{0, 64}, ITEM_SIZE};
    _pdfView.frame = _sclView.bounds;
}

- (void)initViews{
    UIScrollView *tempScl = [[UIScrollView alloc] initWithFrame:(CGRect){{0, NAVBAR_HEIGHT + STATUSBAR_HEIGHT}, ITEM_SIZE}];
    tempScl.showsVerticalScrollIndicator = NO;
    tempScl.showsHorizontalScrollIndicator = NO;
    tempScl.delegate = self;
    tempScl.maximumZoomScale = 2.5;
    _sclView = tempScl;
    [self.view addSubview:tempScl];
    
    PDFView *pdfView = [PDFINSTANCE pdfViewForPage:_index];
    pdfView.frame = tempScl.bounds;
    _pdfView = pdfView;
    [_sclView addSubview:pdfView];
    
}

#pragma mark - scroll view delegate
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _pdfView;
}

#pragma mark - public mehtods
+ (PDFViewController *)pdfViewControllerForIndex:(NSInteger)index{
    if (index >=0 && index < [PDFINSTANCE totalPages]) {
        return [[self alloc] initWithIndex:index];
    }
    return nil;
}
- (NSInteger)pageIndex{
    return _index;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
