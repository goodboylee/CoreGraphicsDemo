//
//  DetailViewController.m
//  CoreGraphicDemo
//
//  Created by lotus on 2017/12/15.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "DetailViewController.h"
#import "GradientView.h"

@interface DetailViewController ()
{
    GradientType _type;
}
@end

@implementation DetailViewController

- (instancetype)initWithType:(GradientType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
}

- (void)initViews{
    self.view.backgroundColor = [UIColor cyanColor];
    
    CGFloat space = 10;
    GradientView *view = [[GradientView alloc] initWithFrame:CGRectMake(space, 100, SCREEN_WIDTH - space * 2, 250) type:_type];
    [self.view addSubview:view];
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
