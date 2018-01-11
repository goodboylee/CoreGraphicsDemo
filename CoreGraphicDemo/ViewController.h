//
//  ViewController.h
//  CoreGraphicDemo
//
//  Created by lotus on 2017/12/7.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef  NS_ENUM(NSInteger, UsageType){
    UsageTypeEORule = 0,
    UsageTypeClip,
    UsageTypePatterns,
    UsageTypeShadows,
    UsageTypeTransparentLayer,
    UsageTypeSubImage,
    UsageTypeCGLayer,
    UsageTypeConvertImageToPDF
};
@interface ViewController : UIViewController

@property (nonatomic, assign) UsageType type;
@end

