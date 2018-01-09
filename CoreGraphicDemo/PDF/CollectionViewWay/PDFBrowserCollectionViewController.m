//
//  PDFBrowserCollectionViewController.m
//  CoreGraphicDemo
//
//  Created by lotus on 2018/1/6.
//  Copyright © 2018年 lotus. All rights reserved.
//

#import "PDFBrowserCollectionViewController.h"

//views
#import "PDFView.h"
#import "PDFCollectionViewCell.h"

#define NAVBAR_HEIGHT       self.navigationController.navigationBar.frame.size.height
#define STATUSBAR_HEIGHT    [UIApplication sharedApplication].statusBarFrame.size.height
#define ITEM_SIZE           CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - STATUSBAR_HEIGHT - NAVBAR_HEIGHT)

@interface PDFBrowserCollectionViewController ()<UICollectionViewDelegateFlowLayout>
{
    CGPDFDocumentRef _pdfDocument;
}
//datas
@property (nonatomic, strong) NSArray <PDFView *>*views;

@end

@implementation PDFBrowserCollectionViewController

static NSString * const reuseIdentifier = @"PDFCollectionViewCell";

- (void)dealloc{
    CGPDFDocumentRelease(_pdfDocument);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDatas];
    
    // Register cell classes
    [self.collectionView registerClass:[PDFCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    NSLog(@"d %f", self.navigationController.navigationBar.frame.size.height);
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = ITEM_SIZE;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    self.collectionView.collectionViewLayout = layout;
    
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
    NSMutableArray <PDFView *>*tempPdfArr = [NSMutableArray array];
    for (size_t i = 1; i <= totalNumber; i++) {
        PDFView *pdfView = [[PDFView alloc] initWithFrame:(CGRect){CGPointZero, ITEM_SIZE} pdfDocument:tempDoc pageNumber:i];
        [tempPdfArr addObject:pdfView];
    }
    self.views = [tempPdfArr copy];
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _views.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PDFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [cell configureWithView:_views[indexPath.row]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
