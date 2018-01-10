//
//  MainTableViewController.m
//  CoreGraphicDemo
//
//  Created by lotus on 2017/12/13.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "MainTableViewController.h"
#import "ViewController.h"
#import "GradientListTableViewController.h"
#import "PDFBrowserCollectionViewController.h"
#import "PDFViewController.h"

@interface MainTableViewController ()<UIPageViewControllerDataSource>

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

#pragma mark - tbview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    if (indexPath.row == 0) {
        vc.type = UsageTypeEORule;
    }else if (indexPath.row == 1){
        vc.type = UsageTypeClip;
    }else if (indexPath.row == 2){
        vc.type = UsageTypePatterns;
    }else if (indexPath.row == 3){
        vc.type = UsageTypeShadows;
    }else if (indexPath.row == 4 || indexPath.row == 5){
        GradientListTableViewController *vc = [[GradientListTableViewController alloc] initWithStyle:UITableViewStylePlain];
        vc.datas = [@[@"ColorLinear", @"AlphaLinear",@"ColorRadial",@"AlphaRadial", @"shapeAxial", @"shapeRadial"] mutableCopy];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }else if (indexPath.row == 6){
        vc.type = UsageTypeTransparentLayer;
    }else if (indexPath.row == 7){
        vc.type = UsageTypeSubImage;
    }else if (indexPath.row == 8){
        vc.type = UsageTypeCGLayer;
    }else if (indexPath.row == 9){
        //the first way to show pdf
//        PDFBrowserCollectionViewController *vc = (PDFBrowserCollectionViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"PDFBrowserCollectionViewController"];
//        [self.navigationController pushViewController:vc animated:YES];
//        return;
        
        
        
        //the second way to show pdf
        UIPageViewController *pageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"pageVC"];
        //fix bug:ios11以下，push到UIPageVC布局下移
        pageVC.automaticallyAdjustsScrollViewInsets = NO;
        pageVC.dataSource = self;
        pageVC.view.backgroundColor = [UIColor whiteColor];
        [pageVC setViewControllers:@[[PDFViewController pdfViewControllerForIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
            
        }];
        [self.navigationController pushViewController:pageVC animated:YES];
        return;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UIPageViewController delegate
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(PDFViewController *)viewController{
    NSInteger index = viewController.pageIndex;
    return [PDFViewController pdfViewControllerForIndex:index - 1];
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(PDFViewController *)viewController{
    NSInteger index = viewController.pageIndex;
    return [PDFViewController pdfViewControllerForIndex:index+1];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/





@end
