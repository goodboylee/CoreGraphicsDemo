//
//  PDFDataSource.m
//  CoreGraphicDemo
//
//  Created by lotus on 2018/1/9.
//  Copyright © 2018年 lotus. All rights reserved.
//

#import "PDFDataSource.h"
#import "LTSPDFView.h"

static PDFDataSource *shareObject = nil;

@interface PDFDataSource()
{
    CGPDFDocumentRef _pdfDocument;
}
@property (nonatomic, strong) NSArray <LTSPDFView *>*views;
@end

@implementation PDFDataSource

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareObject = [[super allocWithZone:NULL] init];
    });
    return shareObject;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    return [PDFDataSource shareInstance];
}
- (instancetype)copy{
    return [PDFDataSource shareInstance];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initDatas];
    }
    return self;
}

- (void)initDatas{
    //create pdfDocment object
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Blocks 编程要点.pdf" withExtension:nil];
    if (url == nil) {
        NSLog(@"the url is not exist.");
        return;
    }
    CFURLRef pdfURL = (__bridge_retained CFURLRef)url;
    CGPDFDocumentRef tempDoc = CGPDFDocumentCreateWithURL(pdfURL);
    if (tempDoc == NULL) {
        NSLog(@"the pdf docment is not exist.");
        return;
    }
    _pdfDocument = tempDoc;
    CFRelease(pdfURL);
    
    //get the total pdf page's number
    size_t totalNumber = CGPDFDocumentGetNumberOfPages(tempDoc);
    NSMutableArray <LTSPDFView *>*tempPdfArr = [NSMutableArray array];
    for (size_t i = 1; i <= totalNumber; i++) {
        LTSPDFView *pdfView = [[LTSPDFView alloc] initWithFrame:CGRectZero pdfDocument:tempDoc pageNumber:i];
        [tempPdfArr addObject:pdfView];
    }
    self.views = [tempPdfArr copy];
}
#pragma mark - public mehtods
- (LTSPDFView *)pdfViewForPage:(NSInteger)page{
    NSParameterAssert(page >= 0 && page < _views.count);
    
    return _views[page];
}
- (NSInteger)totalPages{
    return _views.count;
}
@end
